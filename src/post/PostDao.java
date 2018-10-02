package post;

import util.CommonDao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PostDao extends CommonDao {

	private PostDao() {
	}

	public static PostDao getInstance() {
		return LazyHolder.INSTANCE;
	}

	public int getPostCnt() {
		int cnt = 0;
		String sql = "select count(*) as totalCount from POST";
		try (ResultSet rs = openConnection().executeQuery(sql)) {
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			System.err.println("PostDao function(getPostCnt) Something Problem!!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return cnt;
	}

	public List<PostDto> getPostList(int pageNum) {
		int num = pageNum * 10;
		String sql = "select B.* " +
				"from (select /*+index_desc(A IDX)*/ ROWNUM as RNUM, A.* " +
				"from (select * " +
				"from POST order by IDX desc) A " +
				"where ROWNUM <= " + num + ") B " +
				"where B.RNUM >= " + (num - 9);

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
		String sql = "insert into POST (IDX, TITLE, WRITER, REG_DATE, CONTENT) " +
				"values (POST_SEQ.nextval, '" + post.getTitle() + "', '" + post.getWriter() + "', sysdate, '" + post.getContent() + "')";
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
		String sql = "select * from POST where IDX = " + idx;
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

	private PreparedStatement setPreparedStatement(PreparedStatement pstmt, Object status) throws SQLException {
		if (status instanceof String) {
			pstmt.setString(1, (String) status);
		} else {
			pstmt.setInt(1, (int) status);
		}
		return pstmt;
	}

	private static class LazyHolder {
		static final PostDao INSTANCE = new PostDao();
	}

}
