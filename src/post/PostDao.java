package post;

import util.CommonDao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PostDao extends CommonDao {

	private PostDao() {
	}

	public static PostDao getInstance() {
		return PostDao.LazyHolder.INSTANCE;
	}

	public List<PostDto> getPostList() {
		String sql = "SELECT * FROM post ORDER BY idx DESC";
		ArrayList<PostDto> postList = new ArrayList<>();
		try (ResultSet rs = openConnection().executeQuery(sql)) {
			while (rs.next()) {
				PostDto post = new PostDto();
				post.setIdx(rs.getInt("idx"));
				post.setTitle(rs.getString("title"));
				post.setWriter(rs.getString("writer"));
				post.setReg_date(rs.getString("reg_date"));
				post.setCount(rs.getInt("count"));
				post.setContent(rs.getString("content"));
				postList.add(post);
			}
			closeConnection();
		} catch (SQLException e) {
			System.err.println("PostDao function(getPostList) Something Problem!!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return postList;
	}

	public int insertPost(PostDto post) {
		int result = -1;
		String sql = "INSERT INTO POST (idx, title, writer, reg_date, content) " +
				"VALUES (post_seq.nextval, '" + post.getTitle() + "', '" + post.getWriter() + "', sysdate, '" + post.getContent() + "')";
		System.out.println();
		try (Statement stmt = openConnection()) {
			result = stmt.executeUpdate(sql);
			closeConnection();
		} catch (SQLException e) {
			System.err.println("PostDao function(insertPost) Something Problem!!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	public PostDto getPost(int idx) {
		String sql = "SELECT * FROM post WHERE idx = " + idx;
		PostDto post = new PostDto();
		try (ResultSet rs = openConnection().executeQuery(sql)) {
			while (rs.next()) {
				post.setIdx(rs.getInt("idx"));
				post.setTitle(rs.getString("title"));
				post.setWriter(rs.getString("writer"));
				post.setReg_date(rs.getString("reg_date"));
				post.setCount(rs.getInt("count"));
				post.setContent(rs.getString("content"));
			}
			closeConnection();
		} catch (SQLException e) {
			System.err.println("PostDao function(getPost) Something Problem!!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return post;
	}

	private static class LazyHolder {
		static final PostDao INSTANCE = new PostDao();
	}

}
