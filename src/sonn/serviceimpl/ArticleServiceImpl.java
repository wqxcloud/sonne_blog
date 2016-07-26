package sonn.serviceimpl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import sonn.dao.ArticleDao;
import sonn.entity.Article;
import sonn.service.ArticleService;
import sonn.util.Page;
import sonn.util.PageInfo;
import sonn.util.Principal;


/**
 * @author ����
 * @date 2016.04.21
 * @description:����serviceʵ����
 */
@Service("articleServiceImpl")
public class ArticleServiceImpl extends BaseServiceImpl<Article> implements ArticleService
{
	
	@Resource(name = "articleDaoImpl")
	private ArticleDao articleDao;
	
	@Resource(name = "articleDaoImpl")
	public void setBaseDao(ArticleDao articleDao)
	{
		super.setBaseDao(articleDao);
	}

	@Override
	public List<Article> findAllArticle() 
	{
		return articleDao.findAllArticles();
	}
	
	/*
	 * ����article�ô洢��·��   
	 */
	@Override
	public String getArticleUrl(Article article,HttpServletRequest request,Principal userPrincipal)
	{
		String basePath = "d:\\apache-tomcat-7.0.52\\article\\";
		String articleUrl = basePath + userPrincipal.getUsername()+"\\"
		                                    + article.getTitle() + ".txt";
		return articleUrl;
	}

	/*
	 * �����û�����������
	 */
	@Override
	public Page<Article> getArticlesByUsername(String username,PageInfo pageInfo) 
	{
		return articleDao.getArticlesByUsername(username,pageInfo);
	}

}