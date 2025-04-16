package dao;

import model.User;
import util.DbConnectionUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public class UserDAO {
    public static int createUser(User user) {
        String sql = "INSERT INTO USER (name,email, password,role,phone) VALUES (?,?,?,?,?)";
        try( Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS)
        ){
            ps.setString(1, user.getName());
            ps.setString(2,user.getEmail());
            ps.setString(3,user.getPassword());
            ps.setString(4,user.getRole());
            ps.setString(5,user.getPhone());
            int rowsAffected = ps.executeUpdate();
            if(rowsAffected>0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()){
                    return rs.getInt(1);
                }
            }


        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return -1;

    }

}
