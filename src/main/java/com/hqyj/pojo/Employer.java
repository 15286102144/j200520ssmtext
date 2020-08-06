package com.hqyj.pojo;

import javax.sound.midi.Soundbank;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Employer  extends MyPage{
    private Integer id;

    private String empName;

    private String sex;

    @Override
    public String toString() {
        return "Employer{" +
                "id=" + id +
                ", empName='" + empName + '\'' +
                ", sex='" + sex + '\'' +
                ", job='" + job + '\'' +
                ", updateTime=" + updateTime +
                ", dId=" + dId +
                '}';
    }

    private String job;

    private Date updateTime;
    private  Department dep;

    public Department getDep() {
        return dep;
    }

    public void setDep(Department dep) {
        this.dep = dep;
    }

    private Integer dId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getUpdateTime() {
        if (this.updateTime!=null){
            SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
            return  dateFormat.format(updateTime);
        }
        return "";
    }

    public void setUpdateTime(String updateTime) throws ParseException {
        if (updateTime!=null){
            SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
            this.updateTime=dateFormat.parse(updateTime);
        }else {
            this.updateTime = new Date();
        }
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}