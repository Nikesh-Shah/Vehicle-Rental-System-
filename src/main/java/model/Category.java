package model;

public class Category {
    private int categoryId;
    private String categoryName;
    private byte[] image;

    public Category(String categoryName, byte[] image) {
        this.categoryName = categoryName;
        this.image = image;
    }

    public Category(int categoryId, byte[] image, String categoryName) {
        this.categoryId = categoryId;
        this.image = image;
        this.categoryName = categoryName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }
}
