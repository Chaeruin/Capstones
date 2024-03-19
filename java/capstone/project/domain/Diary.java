package capstone.project.domain;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class Diary {

    private int diaryId;

    @NotEmpty
    private String memberId; //member ID, 외래키

    @NotEmpty
    private String writeDate; //작성 일자

    @NotEmpty
    private String content; //일기 내용

}