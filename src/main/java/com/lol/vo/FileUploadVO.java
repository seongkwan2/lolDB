package com.lol.vo;

import lombok.Data;

@Data
public class FileUploadVO {
    private long f_num;
    private long b_num; //게시글 번호
    private String f_original_name;
    private String f_upload_name;
    private String f_upload_path;
    private String f_ext;
    private Integer f_size;
    
}