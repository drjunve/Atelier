package com.edu.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Mapper
public interface IMemberService {

	//회원목록
	public List<MemberDTO> select();
	//회원가입
	public int insert(MemberDTO memberDTO);
	//회원정보출력
	public MemberDTO selectOne(MemberDTO memberDTO);
	//회원정보수정
	public int update(MemberDTO memberDTO);
	//회원탈퇴(삭제가 아닌 비활성화로 바꿀 예정)
	public int delete(MemberDTO memberDTO);
	
	/*****여기서부터 내가 만든 것*******/
	//이메일 중복검사(select)
	public int emailOverlap(MemberDTO memberDTO) throws Exception;
	//로그인(select)
	public MemberDTO login(MemberDTO memberDTO);
	//비밀번호 찾기(아이디 조회 select)
	public MemberDTO findPassIdSelect(MemberDTO memberDTO);
	//프로필 사진 업로드
	public MemberDTO uploadProfile(MemberDTO memerDTO);
}
