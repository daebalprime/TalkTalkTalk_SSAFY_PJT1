package com.ssafy.d204.api.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.d204.db.entity.Question;
import com.ssafy.d204.db.repository.QuestionDao;

@Service
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	private QuestionDao questionDao;
	
	@Override
	public List<Question> retrieveQuestion() {
		return questionDao.retrieveQuestion(); 
	}

	@Override
	public Question detailQuestion(int idx) {
		return questionDao.detailQuestion(idx);
	}

	@Override
	public boolean writeQuestion(Question content) {
		return questionDao.writeQuestion(content);
	}

	@Override
	public boolean updateQuestion(Question content) {
		return questionDao.updateQuestion(content);
	}

	@Override
	public boolean deleteQuestion(int idx) {
		return questionDao.deleteQuestion(idx);
	}

}
