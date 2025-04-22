package model;
public class Category {
    private int categoryId;
    private String name;
    private String image;
    private String description;

    // Constructors
    public Category() {}

    public Category(int categoryId, String name, String image, String description) {
        this.categoryId = categoryId;
        this.name = name;
        this.image = image;
        this.description = description;
    }

    // Getters and Setters
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}