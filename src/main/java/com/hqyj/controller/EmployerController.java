package com.hqyj.controller;

import com.hqyj.pojo.Department;
import com.hqyj.pojo.Employer;
import com.hqyj.service.EmployerService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

@RequestMapping("emp")//配置EmployerController类映射url
@Controller
public class EmployerController {
    @Autowired
    private EmployerService service;
    @Autowired
    Department department;

    @RequestMapping("list.do")//类似方法名通过list.do执行相应的方法
    public String list(Employer emp, ModelMap map) {
        HashMap<String, Object> listMap = service.selectByPage(emp);
        map.addAttribute("data", listMap);
        //存查询数据到前端页面
        map.addAttribute("empName", emp.getEmpName());
        map.addAttribute("sex", emp.getSex());
        //定义返回页面
        return "empList";
    }
//修改页面
    @RequestMapping("updatePage.do")
    public String updatePage(@RequestParam("id") int id, ModelMap map) {
        Employer emp = service.selectByid(id);
        map.addAttribute("emp", emp);
        List<Department> list = service.select();
        map.addAttribute("dep", list);
        return "updatePage";
    }

    //修改method = RequestMethod.POST提交方式value = "update.do"地址
    @RequestMapping(method = RequestMethod.POST, value = "update.do")
    public String update(Employer emp, ModelMap map) {
        if (service.update(emp) > 0) {
            Employer empl = new Employer();
            HashMap<String, Object> listMap = service.selectByPage(empl);
            map.addAttribute("data", listMap);
            return "redirect:list.do";
        } else {
            map.addAttribute("info", "修改失败");
            return "updatePage";
        }
    }

    //删除
    @RequestMapping("delete.do")
    public String delete(@RequestParam("id") int id, ModelMap map) {
        if (service.delete(id) > 0) {
            Employer empl = new Employer();
            HashMap<String, Object> listMap = service.selectByPage(empl);
            map.addAttribute("data", listMap);
        } else {
            map.addAttribute("info", "删除失败");
        }
        return "redirect:list.do";
    }

    //添加页面
    @RequestMapping("addPage.do")
    public String add(ModelMap map) {
        List<Department> list = service.select();
        map.addAttribute("dep", list);
        return "add";
    }

    //添加
    @RequestMapping(method = RequestMethod.POST, value = "add.do")
    public String add(Employer emp, ModelMap map) {
        if (service.insert(emp) > 0) {
            Employer empl = new Employer();
            HashMap<String, Object> listMap = service.selectByPage(empl);
            map.addAttribute("data", listMap);
            return "redirect:list.do";
        } else {
            map.addAttribute("info", "添加失败");
            return "add";
        }
    }

    //ajax列表
    @RequestMapping("ajaxPage.do")
    public String listajax(ModelMap map) {
        return "ajax";
    }

    //ajax请求
    @RequestMapping("ajax.do")
    @ResponseBody//转换json数据
    public HashMap<String, Object> ajax(Employer emp) {
        return service.selectByPage(emp);
    }

    //ajax修改
    @RequestMapping("updateajax.do")
    @ResponseBody//转换json数据
    public HashMap ajaxupdate(Employer emp) {
        HashMap map = new HashMap();
        if (service.update(emp) > 0) {
            map.put("info", "成功");
        } else {
            map.put("info", "失败");
        }
        return map;
    }

    //ajax删除
    @RequestMapping("deleteajax.do")
    @ResponseBody//转换json数据
    public HashMap ajaxdelete(Employer emp) {
        System.err.println("emp = " + emp);
        HashMap map = new HashMap();
        if (service.delete(emp.getId()) > 0) {
            map.put("info", "成功");
        } else {
            map.put("info", "失败");
        }
        return map;
    }

    //添加页面ajax
    @RequestMapping("addajax.do")
    @ResponseBody//转换json数据
    public HashMap ajaadd(Employer emp) {
        System.err.println("emp = " + emp);
        HashMap map = new HashMap();
        if (service.insert(emp) > 0) {
            map.put("inf", "成功");
        } else {
            map.put("inf", "失败");
        }
        return map;
    }

    //添加页面ajax
    @RequestMapping("delAjax.do")
    @ResponseBody//转换json数据
    public HashMap delAjax(@RequestParam("id") String id) {
        System.err.println("id = " + id);
        HashMap map = new HashMap();
        //把字符串转换集合
        List<String> list = Arrays.asList(id.split(","));
        System.err.println("list = " + list);
        if (service.del(list) > 0) {
            map.put("inf", true);
        } else {
            map.put("inf", false);
        }
        return map;
    }

    @RequestMapping("upPaged.do")
    public String uppgae() {
        return "fileupload";
    }

    @RequestMapping(method = RequestMethod.POST, value = "upload.do")
    public String upload(@RequestParam("files") MultipartFile[] file, HttpServletRequest request) throws IOException {
       //获取服务器地址
        String filePath = request.getSession().getServletContext().getRealPath("upload");
        System.err.println("filePath = " + filePath);
        //遍历文件对象数组，取出文件全名
        if (null != file && file.length > 0) {
            try {
                for (int i = 0; i < file.length; i++) {
                    MultipartFile f = file[i];
                    System.err.println("文件名 = " + f.getOriginalFilename());
                    //创建文件对象io
                    File ff = new File("" + filePath + "/" + f.getOriginalFilename() + "");
                    //判断目录是否存在
                    if (!ff.isDirectory()) {
                        //创建目录
                        ff.mkdirs();
                    }
                    //创建文件
                    f.transferTo(ff);
                    request.setAttribute("info", "文件上传成功");
                }
            } catch (IOException e) {
                e.printStackTrace();
                request.setAttribute("info", "文件上传失败");
            }
        }
        return "fileupload";
    }
    //设置返回值类型
 //@RequestMapping(value = "ajax.do" ,produces = "application/text/html; charset=utf-8")
    @RequestMapping(method = RequestMethod.POST,value = "fileTransAjax.do")
    @ResponseBody
    public boolean fileTransAjax(@RequestParam("files") MultipartFile[] file, HttpServletRequest request) throws IOException {
        //获取服务器地址
        String filePath = request.getSession().getServletContext().getRealPath("upload");
        System.err.println("filePath = " + filePath);
        //遍历文件对象数组，取出文件全名
        if (null != file && file.length > 0) {
            try {
                for (int i = 0; i < file.length; i++) {
                    MultipartFile f = file[i];
                    System.err.println("文件名 = " + f.getOriginalFilename());
                    //创建文件对象io
                    File ff = new File("" + filePath + "/" + f.getOriginalFilename() + "");
                    //判断目录是否存在
                    if (!ff.isDirectory()) {
                        //创建目录
                        ff.mkdirs();
                    }
                    //创建文件
                    f.transferTo(ff);
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
       return false;
    }
    //下载页面
    @RequestMapping("downfile.do")
    public String  down(){
        return "downfile";
    }
    //文件下载
    @RequestMapping("download.do")
    public ResponseEntity<byte[]> downLoad(@RequestParam("fileName") String fileName, HttpServletRequest request) throws IOException {
        // 找到文件下载目录
        String filePath = request.getSession().getServletContext().getRealPath("upload");
        //创建文件对象
        File f = new File(""+filePath+"/"+fileName+"");
        //创建http头部对象
        HttpHeaders http = new HttpHeaders();
        //设置下载响应头部
        http.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        //解决下载文件名 乱码的问题
        String downName= new String(fileName.getBytes("utf-8"),"ISO8859-1");
        //下载文件
        http.set("Content-Disposition","attachment;filename="+downName+"");
        //   把文件以二进制形式写回
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(f), http, HttpStatus.CREATED);
    }
    @RequestMapping("text.do")
    public String text(){
        return "text";
    }
    //接收数组方式1
//    @RequestMapping(value = "textajax.do")
//    @ResponseBody
//    public String textajax(HttpServletRequest request){
//     String[] s = request.getParameterValues("a[]");
//       for (String s1 : s) {
//            System.out.println("s222222222222221 = " + s1);
//        }
//        return "222";
//    }
   /* //接收数组对象
    @RequestMapping(value = "textajax.do")
    @ResponseBody
    public String textajax(@RequestBody List<Department> department){
        for (Department department1 : department) {
            System.out.println("department1 = " + department1);
        }
        return "222";
    }*/
    //接收集合2通过设置  traditional:true,
    @RequestMapping(value = "textajax.do")
    @ResponseBody
    public String textajax2(@RequestBody String[] a){
        for (String s : a) {
            System.out.println("s = " + s);
        }
        return "222";
    }
    @RequestMapping("lise.do")
    public String text1(){
        return "formlise";
    }
    //表单序列化
    @RequestMapping("lise1.do")
    @ResponseBody
    public String text2(Department department){
        System.out.println("department = " + department);
        return "123";
    }
    //跨域访问
    @RequestMapping("all.do")
    @ResponseBody
    public String text3(HttpServletResponse resp){
        //允许所有域名访问该资源
        resp.setHeader("Access-Control-Allow-Origin","*");
        /*resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        resp.setHeader("Access-Control-Max-Age", "3600");*/
        resp.setHeader("Access-Control-Allow-Headers", "x-requested-with,Authorization");
        /*  resp.setHeader("Access-Control-Allow-Credentials","true");*/
       return "333";
    }
    @RequestMapping("firstShiro.do")
    public String shi(){
        return "login";
    }
    @RequestMapping("index.do")
    public String shdi(){
        return "/index";
    }
    @RequestMapping("Library.do")
    public String shdi222(){
        System.out.println("1111111111111111111111111111111111111111111111111111111");
        return "Library";
    }
}
