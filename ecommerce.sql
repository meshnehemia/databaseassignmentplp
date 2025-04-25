CREATE TABLE attribute_category (
  attribute_category_id INT NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(100) NOT NULL,
  description TEXT,
  PRIMARY KEY (attribute_category_id)
);

CREATE TABLE attribute_type (
  attribute_type_id INT NOT NULL AUTO_INCREMENT,
  type_name VARCHAR(50) NOT NULL,
  data_type ENUM('text','number','boolean','date') NOT NULL,
  PRIMARY KEY (attribute_type_id)
);

CREATE TABLE brand (
  brand_id INT NOT NULL AUTO_INCREMENT,
  brand_name VARCHAR(100) NOT NULL,
  brand_description TEXT,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (brand_id)
);

CREATE TABLE color (
  color_id INT NOT NULL AUTO_INCREMENT,
  color_name VARCHAR(50) NOT NULL,
  color_code VARCHAR(20) NOT NULL,
  hex_value VARCHAR(7) DEFAULT NULL,
  PRIMARY KEY (color_id)
);

CREATE TABLE product (
  product_id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  product_description TEXT,
  brand_id INT DEFAULT NULL,
  category_id INT DEFAULT NULL,
  base_price DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (product_id),
  KEY brand_id (brand_id),
  KEY category_id (category_id),
  CONSTRAINT product_ibfk_1 FOREIGN KEY (brand_id) REFERENCES brand (brand_id) ON DELETE SET NULL,
  CONSTRAINT product_ibfk_2 FOREIGN KEY (category_id) REFERENCES product_category (category_id) ON DELETE SET NULL
);

CREATE TABLE product_attribute (
  attribute_id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  attribute_name VARCHAR(100) NOT NULL,
  attribute_value TEXT NOT NULL,
  attribute_category_id INT DEFAULT NULL,
  attribute_type_id INT DEFAULT NULL,
  PRIMARY KEY (attribute_id),
  KEY product_id (product_id),
  KEY attribute_category_id (attribute_category_id),
  KEY attribute_type_id (attribute_type_id),
  CONSTRAINT product_attribute_ibfk_1 FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE,
  CONSTRAINT product_attribute_ibfk_2 FOREIGN KEY (attribute_category_id) REFERENCES attribute_category (attribute_category_id) ON DELETE SET NULL,
  CONSTRAINT product_attribute_ibfk_3 FOREIGN KEY (attribute_type_id) REFERENCES attribute_type (attribute_type_id) ON DELETE SET NULL
);

CREATE TABLE product_category (
  category_id INT NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(100) NOT NULL,
  parent_category_id INT DEFAULT NULL,
  category_description TEXT,
  PRIMARY KEY (category_id),
  KEY parent_category_id (parent_category_id),
  CONSTRAINT product_category_ibfk_1 FOREIGN KEY (parent_category_id) REFERENCES product_category (category_id) ON DELETE SET NULL
);

CREATE TABLE product_image (
  image_id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  image_url VARCHAR(255) NOT NULL,
  alt_text VARCHAR(255) DEFAULT NULL,
  is_primary TINYINT(1) DEFAULT '0',
  display_order INT DEFAULT '0',
  PRIMARY KEY (image_id),
  KEY product_id (product_id),
  CONSTRAINT product_image_ibfk_1 FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
);

CREATE TABLE product_item (
  item_id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  sku VARCHAR(50) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  quantity_in_stock INT NOT NULL DEFAULT '0',
  size_id INT DEFAULT NULL,
  color_id INT DEFAULT NULL,
  variation_id INT DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (item_id),
  UNIQUE KEY sku (sku),
  KEY product_id (product_id),
  KEY size_id (size_id),
  KEY color_id (color_id),
  KEY variation_id (variation_id),
  CONSTRAINT product_item_ibfk_1 FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE,
  CONSTRAINT product_item_ibfk_2 FOREIGN KEY (size_id) REFERENCES size_option (size_id) ON DELETE SET NULL,
  CONSTRAINT product_item_ibfk_3 FOREIGN KEY (color_id) REFERENCES color (color_id) ON DELETE SET NULL,
  CONSTRAINT product_item_ibfk_4 FOREIGN KEY (variation_id) REFERENCES product_variation (variation_id) ON DELETE SET NULL
);

CREATE TABLE product_variation (
  variation_id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  variation_type ENUM('size','color','style','other') NOT NULL,
  PRIMARY KEY (variation_id),
  KEY product_id (product_id),
  CONSTRAINT product_variation_ibfk_1 FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
);

CREATE TABLE size_category (
  size_category_id INT NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (size_category_id)
);

CREATE TABLE size_option (
  size_id INT NOT NULL AUTO_INCREMENT,
  size_category_id INT DEFAULT NULL,
  size_value VARCHAR(20) NOT NULL,
  size_description VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (size_id),
  KEY size_category_id (size_category_id),
  CONSTRAINT size_option_ibfk_1 FOREIGN KEY (size_category_id) REFERENCES size_category (size_category_id) ON DELETE CASCADE
);