package capstone.project.repository.mybatis;

import capstone.project.domain.Diary;
import capstone.project.repository.diary.DiaryUpdateApiDto;
import capstone.project.repository.diary.DiaryUpdateDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface DiaryMapper {

    void save(Diary diary);

    Diary findNewDiary();

    void update(@Param("diaryId") Integer diaryId, @Param("updateParam") DiaryUpdateDto updateParam);

    void delete(Integer diaryId);

    Optional<Diary> findById(Integer diaryId);

    List<Diary> findAll(Diary diary);

    List<Diary> findByMemberId(String memberId);

    //Api용
    void update(@Param("diaryId") Integer diaryId, @Param("updateParam") DiaryUpdateApiDto updateParam);
}
