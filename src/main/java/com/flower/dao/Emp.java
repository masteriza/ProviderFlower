package com.flower.dao;

/**
 * Created by user on 07.08.2015.
 */
public class Emp {
    int empno;
    String ename;

    public Emp() {
    }

    public Emp(int empno, String ename) {
        this.empno = empno;
        this.ename = ename;
    }

    public int getEmpno() {
        return empno;
    }

    public void setEmpno(int empno) {
        this.empno = empno;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }



}
