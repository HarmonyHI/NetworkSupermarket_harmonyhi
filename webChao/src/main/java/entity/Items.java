package entity;
import java.util.Date;
import java.util.Objects;
public class Items {
    private final String id;
    private final String name;
    private final String describe;
    private final double amount;
    private final double price;
    private final String vendor;
    private final Date update;
    private final float score;
    private final int status;
    private final String unit;
    private final String picture;

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescribe() {
        return describe;
    }

    public double getAmount() {
        return amount;
    }

    public double getPrice() {
        return price;
    }

    public String getVendor() {
        return vendor;
    }

    public Date getUpdate() {
        return update;
    }

    public float getScore() {
        return score;
    }

    public int getStatus() {
        return status;
    }

    public String getUnit() {
        return unit;
    }

    public String getPicture() {
        return picture;
    }

    public Items(String id, String name, String describe, double amount, double price, String vendor, Date update, float score, int status, String unit, String picture) {
        this.id = id;
        this.name = name;
        this.describe = describe;
        this.amount = amount;
        this.price = price;
        this.vendor = vendor;
        this.update = update;
        this.score = score;
        this.status = status;
        this.unit = unit;
        this.picture = picture;
    }
    @Override
    public boolean equals(Object obj) {
        if(this == obj) {
            return true;
        }
        if(obj instanceof Items) {
            Items i = (Items)obj;
            return Objects.equals(this.getId(), i.getId()) && this.getName().equals(i.getName());
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return (this.getId() + this.getName()).hashCode();
    }

    public String toString() {
        return "商品编号：" + this.getId() + " 商品名称：" + this.getName();
    }
}
