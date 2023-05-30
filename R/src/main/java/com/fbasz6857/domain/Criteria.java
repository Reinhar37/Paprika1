package com.fbasz6857.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum; //페이지번호
	private int amount; //한페이지당 몇 개의 데이터를 보여줄 것인지
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getStart () {
		return (this.pageNum - 1) * this.amount;
	}
	
	/*
	 * 검색 항목이 TC 로 왔을때 배열에 각각글자를 넣어주는 함수
	 */
	public String[] getTypeArr() {
		return this.type == null? new String[] {}: type.split("");
	}
	
	/*
	 * 웹페이지에서 매번 파라미터를 유지하는 일이 번거롭고 힘들다면 아래 메소드를 사용하세요
	 */
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.amount)
				.queryParam("type", this.type)
				.queryParam("keyword", this.keyword);
		
		return builder.toUriString();
	}
	
	public String getPagingLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("amount", this.amount)
				.queryParam("type", this.type)
				.queryParam("keyword", this.keyword);
		
		return builder.toUriString();
	}
}
