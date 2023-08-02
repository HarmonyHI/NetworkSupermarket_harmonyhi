/*
 Navicat Premium Data Transfer

 Source Server         : MyConnect
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : network_supermarket

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 30/12/2022 08:56:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `out_cart_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '购物车商品ID',
  `user_id` bigint NOT NULL COMMENT '外键，用户id，服从于user',
  `goods_id` bigint NOT NULL COMMENT '外键，商品id，服从于goods',
  `goods_type_id` bigint NULL DEFAULT NULL COMMENT '外键，商品类型id，服从于goods_type',
  `goods_number` decimal(10, 2) NULL DEFAULT 1.00 COMMENT '购买数量，默认1',
  `discount` decimal(4, 2) NOT NULL DEFAULT 1.00 COMMENT '折扣力度',
  `actually_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '(自动生成)应付价格',
  PRIMARY KEY (`out_cart_id`) USING BTREE,
  UNIQUE INDEX `caid`(`out_cart_id`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE,
  INDEX `gid1`(`goods_id`) USING BTREE,
  INDEX `tid1`(`goods_type_id`) USING BTREE,
  CONSTRAINT `gid1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tid1` FOREIGN KEY (`goods_type_id`) REFERENCES `goods_type` (`goods_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid` FOREIGN KEY (`user_id`) REFERENCES `users` (`consumer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for comments_media_url
-- ----------------------------
DROP TABLE IF EXISTS `comments_media_url`;
CREATE TABLE `comments_media_url`  (
  `purchase_id` bigint NOT NULL COMMENT '外键，所属评论ID，服从于purchase_relations',
  `media_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '媒体文件ID，唯一',
  `in_group_id` int NULL DEFAULT NULL COMMENT '单条评论内的媒体文件ID，评论内唯一，代表图片顺序',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'http://gg.gg/12uucq' COMMENT '媒体文件URL',
  PRIMARY KEY (`media_id`) USING BTREE,
  UNIQUE INDEX `meid_main`(`media_id`) USING BTREE,
  INDEX `meid_a`(`purchase_id`) USING BTREE,
  CONSTRAINT `meid_a` FOREIGN KEY (`purchase_id`) REFERENCES `purchase_relations` (`purchase_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments_media_url
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_id` bigint NOT NULL COMMENT '（自动生成）商品ID',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `goods_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品介绍',
  `amount` decimal(10, 2) NOT NULL DEFAULT 9999.00 COMMENT '剩余量，默认9999.00，调用方手动扣除',
  `price` decimal(10, 2) NOT NULL COMMENT '商品单价',
  `vendor_id` bigint NULL DEFAULT NULL COMMENT '外键，商家ID号，服从于vendor',
  `listing_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上架时间，默认2000-01-01',
  `goods_score` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '总评分，需要触发器B，当purchase_relations改变时自动计算其总评分',
  `goods_status` int NOT NULL DEFAULT 1 COMMENT '商品状态，默认0，1正在出售，0暂时下架，2缺货（需要触发器）',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '个' COMMENT '商品单位，默认\"个”',
  `head_photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '首图',
  PRIMARY KEY (`goods_id`) USING BTREE,
  UNIQUE INDEX `gid`(`goods_id`) USING BTREE,
  INDEX `vid`(`vendor_id`) USING BTREE,
  CONSTRAINT `vid` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (2848984, '耳坠', '一般女生都喜欢的装饰品，有时候在路上看到这样的地摊，难免会走近看看，往往看到自己喜欢的就买了。', 1936.00, 6.87, 235750163, '2020-01-19 00:00:00', '3.50', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (6291540, '奶茶', '奶和茶的搭配，让你的舌尖甜甜的满满的幸福感，冬天握在手心，暖在心里。', 2776.00, 8.90, 235740687, '2020-01-17 00:00:00', '3.75', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (6454165, '肉夹馍', '肉夹馍，使馍和肉形成完美结合，关中地区的经典吃法，已经风靡大江南北，肉质四溢的感觉沁人心脾。', 6502.00, 4.56, 235726740, '2020-01-20 00:00:00', '7.2 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (13732011, '袜子', '袜子款式多样，价格也不贵，要是摆地摊卖袜子，想必也能吸引不少的人来买。', 7665.00, 4.52, 235766924, '2020-01-24 00:00:00', '8.2 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (14474266, '章鱼小丸子', '来自日本的章鱼烧更名而成，名字可爱，丸子更可爱，风中摇曳的买皮酥，仿佛在热情的向你挥动双手。', 5069.00, 0.33, 235750163, '2020-01-13 00:00:00', '1.50', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (16857887, '手表', '现在很多摆摊卖手表的小贩，虽然卖的人多，但不得不说卖手表真的是一个很好的选择。', 3508.00, 3.58, 235751798, '2020-01-25 00:00:00', '3.1 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (29087391, '烤红薯', '健康食品不会消失在街头巷尾，捧着热烘烘的新鲜红薯，温暖整个人。', 9765.00, 2.27, 235781881, '2020-01-17 00:00:00', '4.90', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (29796372, '手机壳', '现代青年每天与手机形影不离，生活中比什么都要爱护它，所以很多人都喜欢把自己的手机装饰得更好看，而这种经常会换的物品，摆地摊再合适不过了。', 7501.00, 7.35, 235766924, '2020-01-28 00:00:00', '0.2 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (30197556, '毛绒玩具', '摆地摊选择的一定是人流比较密集的地方，而毛绒玩具主要用来吸引女顾客和小孩子。', 9670.00, 6.42, 235740687, '2020-01-06 00:00:00', '7.1 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (34132264, '雨伞', '雨伞可谓是男女老少皆宜，款式风格多样，价格也没有固定的，卖雨伞的利润可想而知。', 1635.00, 4.43, 235704600, '2020-01-03 00:00:00', '3.6 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (37135991, '帆布鞋', '现在的青少年，谁的手机没有几双帆布鞋，这种价格不贵，又富有青春气息的物品一直就很讨人喜欢。', 8727.00, 7.72, 235750163, '2020-01-05 00:00:00', '2.6 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (37936671, '水杯', '水杯有各种各样，而且是个实用的物品，用这个商品摆地摊，也能吸引不少顾客呢。', 4744.00, 0.48, 235777501, '2020-01-14 00:00:00', '9.1 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (38762704, 'T恤', '夏季还没有来临之前，就有一些小商贩们开始摆地摊卖T恤，纯白色的印有英文和卡通人物，按照尺寸大小，卖价到块不等。这类商品在前几年出现的时候遭到顾客的疯抢。不要看它价格低，其实利润还是不错的。摆这类商品的地摊最好选择在居民区夜市或者学校旁边。', 2481.00, 0.29, 235781881, '2020-01-12 00:00:00', '3.3 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (38869730, '手抓饼', '起源于台湾，千层百叠，层如薄纸，用手抓之，面丝千连，香酥可口。', 1964.00, 0.56, 235742290, '2020-01-19 00:00:00', '5.1 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (42535297, 'rfhr', 'hr', 9999.00, 1.00, 235766924, '2022-12-27 22:42:36', NULL, 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (47201884, '小风扇', '这是夏季的标配,很多学校没有安装空调，只能靠小风扇过夜，但学校点之后会断电，那种带USB插口可以靠着充电宝持续供电的小风扇就得到了他们青睐，所以它的销量持续走俏，基本上是人手一个。坐办公室的白领有些也需要这种小风扇。这种功能小风扇在地摊上可以卖到二十三十，但成本只有几块。', 9250.00, 5.74, 235727469, '2020-01-15 00:00:00', '8.9 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (48196202, 'hhhhhhh', 'hhhhhhhhh', 9999.00, 1.00, 235751798, '2022-12-27 22:41:59', NULL, 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (58087883, 'rrrrr', 'rr', 9999.00, 1.00, 235766924, '2022-12-27 22:45:42', NULL, 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (58298810, '煎饼果子', '从小吃到大，现在几乎走到哪个城市，都能在地摊上见到它，热乎乎的煎饼果子，营养又美味，老少皆宜。', 7834.00, 2.39, 235709643, '2020-01-30 00:00:00', '7.0 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (61694478, '炸臭豆腐', '对于有些人来说是避之不及的食物，但是对于有些人来说却是人间的美味，它闻着臭吃着香，有一种特殊的神奇魅力。', 8925.00, 8.21, 235742290, '2020-01-17 00:00:00', '5.0 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (61716169, '烤冷面', '风靡东三省，逐渐向南延伸，已成为街边小吃的心头爱，甜甜辣辣的味道，劲道的面皮，小小的一道小吃，满足了人们对面的各种幻想。', 5644.00, 6.83, 235777501, '2020-01-17 00:00:00', '0.6 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (65934330, '铁板鱿鱼', '皮酥肉香是鱿鱼的特色，不仅是国人的美味，连外国友人都啧啧称奇。', 0.00, 7.46, 235726740, '2020-01-16 00:00:00', '6.9 ', 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (76551266, 'qqqqqqqqqqq', 'qqqqqqqqqqq', 9999.00, 11.00, 235766924, '2022-12-27 22:48:26', NULL, 1, '个', './test-pic/default_pic.jpg');
INSERT INTO `goods` VALUES (395209711, 'wwww', 'wwwww', 9999.00, 11.00, 235766924, '2022-12-27 22:36:25', NULL, 1, '个', './test-pic/default_pic.jpg');

-- ----------------------------
-- Table structure for goods_media_url
-- ----------------------------
DROP TABLE IF EXISTS `goods_media_url`;
CREATE TABLE `goods_media_url`  (
  `media_id` bigint NOT NULL COMMENT '（自动生成）单个媒体文件ID',
  `goods_id` bigint NULL DEFAULT NULL COMMENT '媒体文件所属的商品的统一ID，服从于goods',
  `in_group_id` int NULL DEFAULT NULL COMMENT '组内ID可表示顺序',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'http://gg.gg/12uucq' COMMENT '媒体文件URL',
  PRIMARY KEY (`media_id`) USING BTREE,
  UNIQUE INDEX `gmid`(`media_id`) USING BTREE,
  INDEX `media_group_id`(`goods_id`) USING BTREE,
  CONSTRAINT `mid` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_media_url
-- ----------------------------

-- ----------------------------
-- Table structure for goods_type
-- ----------------------------
DROP TABLE IF EXISTS `goods_type`;
CREATE TABLE `goods_type`  (
  `goods_type_id` bigint NOT NULL COMMENT '商品型号ID，控制purchase_relations，cart',
  `goods_id` bigint NOT NULL COMMENT '商品ID，服从于goods',
  `goods_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品类型描述',
  `type_media_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品该类型的媒体文件URL',
  `in_group_id` bigint NOT NULL COMMENT '商品型号在商品内的ID，可表示顺序',
  PRIMARY KEY (`goods_type_id`) USING BTREE,
  UNIQUE INDEX `gtid`(`goods_type_id`) USING BTREE,
  INDEX `gid`(`goods_id`) USING BTREE,
  CONSTRAINT `gid` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_type
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '（自动生成）订单号',
  `consumer_id` bigint NOT NULL COMMENT '（必填）买家编号',
  `order_generation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '（自动生成）订单生成时间',
  `total_order_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '订单总价,调用方手动增加',
  `shipping_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '（必填）收货地址',
  `order_status` int NOT NULL DEFAULT 0 COMMENT '订单状态（默认0） 0未付款，1已发货，2已成交，3退款中，4已退款，5已付款，6退款已拒绝',
  `shipping_phone_number` bigint NOT NULL COMMENT '（必填）收货电话号码，与账户电话号码无关',
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `oid`(`order_id`) USING BTREE,
  INDEX `customer_id_connecton`(`consumer_id`) USING BTREE,
  CONSTRAINT `cid` FOREIGN KEY (`consumer_id`) REFERENCES `users` (`consumer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 160379426110362821 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for purchase_relations
-- ----------------------------
DROP TABLE IF EXISTS `purchase_relations`;
CREATE TABLE `purchase_relations`  (
  `purchase_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户购买ID',
  `goods_id` bigint NOT NULL COMMENT '商品编码-服从于goods',
  `goods_type_id` bigint NULL DEFAULT NULL COMMENT '商品型号-服从于goods_type',
  `order_id` bigint NOT NULL COMMENT '该商品对应的订单号-服从于order',
  `goods_number` decimal(10, 2) NOT NULL DEFAULT 1.00 COMMENT '商品购买数',
  `user_goods_status` int NOT NULL DEFAULT 0 COMMENT '单商品状态',
  `actually_paid_money` decimal(10, 2) NOT NULL COMMENT '实付款',
  `comments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'null' COMMENT '商品成交后买家评论',
  `score` decimal(10, 2) NULL DEFAULT 5.00 COMMENT '成交后买家评分，0~5小数表示',
  `express_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货物流单号',
  `return_express_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款物流单号',
  PRIMARY KEY (`purchase_id`) USING BTREE,
  UNIQUE INDEX `pid`(`purchase_id`) USING BTREE,
  INDEX `commodity_list_id`(`order_id`) USING BTREE,
  INDEX `goid`(`goods_id`) USING BTREE,
  INDEX `tid`(`goods_type_id`) USING BTREE,
  CONSTRAINT `goid` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oid` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tid` FOREIGN KEY (`goods_type_id`) REFERENCES `goods_type` (`goods_type_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 135646450334953528 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_relations
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `consumer_id` bigint NOT NULL COMMENT '(自动生成)用户ID',
  `consumer_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NonameUser' COMMENT '用户姓名',
  `phone_number` bigint NOT NULL COMMENT '账号对应的手机号，可作为登录账号',
  `gender` int NOT NULL DEFAULT 0 COMMENT '性别，0女，1男，默认0',
  `birthday` date NOT NULL DEFAULT '2020-01-01' COMMENT '生日，默认2000-01-01',
  `consumer_nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '昵称，默认随机',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `user_type` int NOT NULL DEFAULT 0 COMMENT '0普通用户，1vip用户，2svip用户，默认0',
  `costumer_icon_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'http://gg.gg/12uucq' COMMENT '头像，含默认值',
  `exp` int NOT NULL DEFAULT 0 COMMENT '经验值，默认0',
  PRIMARY KEY (`phone_number`, `consumer_id`) USING BTREE,
  UNIQUE INDEX `consumer_id`(`consumer_id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone_number`) USING BTREE,
  INDEX `consumer_name`(`consumer_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (96267586, 'NonameUser', 1848030850, 0, '2020-01-01', '2f70b8a8-8688-11ed-a5f6-00ff5680e7a7', 'ds', 0, 'http://gg.gg/12uucq', 0);
INSERT INTO `users` VALUES (2, '李小璐', 13803022474, 0, '2020-01-22', '爱吃西瓜子', '673943', 1, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (4, '韩先欢', 13805524805, 0, '2020-01-26', 'ddddddddd', '883077', 3, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (14, '张姿妤', 13810276502, 0, '2020-01-28', '种草莓的小行家', '623219', 3, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (15, '梁哲宇', 13817673620, 1, '2020-01-18', 'KUQA_16564684', '316990', 2, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (12, '林国瑞', 13818918021, 1, '2020-01-14', 'WAKP_546848', '231947', 8, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (18, '吕恬然', 13827004146, 1, '2020-01-13', 'WordExp_id1115', '447533', 4, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (1, '王小明', 13834262909, 1, '2020-01-18', '初夏的忧伤', 'aa330134', 2, '\'http://gg.gg/12uucq\'', 6);
INSERT INTO `users` VALUES (13, '刘翊惠', 13839950701, 0, '2020-01-16', 'CETF_3055541', '368628', 4, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (5, '方聪彤', 13859098098, 0, '2020-01-02', '眼前人心上人', '553937', 2, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (11, '许娇翔', 13859620967, 1, '2020-01-06', '仿佛没有时间', '140384', 1, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (16, '李杰文', 13869538941, 1, '2020-01-04', 'PFUX_1656161', '84401', 3, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (10, '陈寿渊', 13871014729, 1, '2020-01-16', 'DIplane', '161077', 8, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (9, '夏潇琦', 13893174123, 0, '2020-01-21', '虚拟', '15697', 2, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (8, '钱欢孟', 13895086451, 0, '2020-01-13', '所谓对象', '966801', 4, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (7, '郑吉万', 13927121280, 1, '2020-01-13', 'Browser', '137374', 5, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (3, '王青', 13927915881, 1, '2020-01-04', 'NYIZ_626164', '759809', 4, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (17, '史路英', 13944055767, 0, '2020-01-24', '养猪的老巫婆', '580987', 5, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (6, '范久然', 13992309231, 0, '2020-01-05', '温柔尝尽了吗', '213434', 3, '\'http://gg.gg/12uucq\'', 0);
INSERT INTO `users` VALUES (67080256, 'NonameUser', 17790788445, 0, '2020-01-01', '87689ce4-8646-11ed-a5f6-00ff5680e7a7', 'Hc766443', 0, 'http://gg.gg/12uucq', 0);
INSERT INTO `users` VALUES (28162630, 'NonameUser', 18147033870, 0, '2020-01-01', 'dc06953b-8719-11ed-a5f6-00ff5680e7a7', 'sg914680', 0, 'http://gg.gg/12uucq', 0);

-- ----------------------------
-- Table structure for vendor
-- ----------------------------
DROP TABLE IF EXISTS `vendor`;
CREATE TABLE `vendor`  (
  `vendor_id` bigint NOT NULL COMMENT '商家ID',
  `vendor_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商家登录密码',
  `vendor_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商家昵称',
  `vendor_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商家地址',
  `vendor_phone` bigint NOT NULL COMMENT '商家手机号码，可作为登录账号',
  `vendor_icon_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商家头像URL',
  PRIMARY KEY (`vendor_id`, `vendor_phone`) USING BTREE,
  UNIQUE INDEX `vendor_id`(`vendor_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vendor
-- ----------------------------
INSERT INTO `vendor` VALUES (235704600, '330134', '善财', '贵州省百色市上甘岭区鞍山路63号住友嘉馨名园', 13843352331, '');
INSERT INTO `vendor` VALUES (235709643, '673943', '楚元', '贵州省安康市伊春区白水路135号溢盈河畔别墅', 13909535916, '');
INSERT INTO `vendor` VALUES (235726740, '759809', '冠诚', '福建省安阳市金山屯区安顺路3号和亭佳苑', 13861841029, '');
INSERT INTO `vendor` VALUES (235727469, '883077', '凯杰', '海南省白银市新青区安福路181号溢盈河畔别墅', 13922257659, '');
INSERT INTO `vendor` VALUES (235740687, '553937', '浩峰', '湖北省安顺市南岔区安汾路9号溢盈河畔别墅', 13919310081, '');
INSERT INTO `vendor` VALUES (235742290, '213434', '兴简', '江苏省巴中市乌马河区安远路44号博泰新苑', 13835463408, '');
INSERT INTO `vendor` VALUES (235750163, '137374', '圣鸿', '云南省白山市友好区白城南路54号东新大厦', 13951483166, '');
INSERT INTO `vendor` VALUES (235751798, '966801', '圣立', '贵州省百色市上甘岭区宝通路36号真新六街坊', 13820493026, '');
INSERT INTO `vendor` VALUES (235766924, '15697', '豪百', '江西省安庆市带岭区北艾路20号金色家园', 13990650885, '');
INSERT INTO `vendor` VALUES (235777501, '161077', '心海', '云南省安康市伊春区宝源路13号耀江花园', 13891285775, '');
INSERT INTO `vendor` VALUES (235777788, '140384', '财华', '海南省巴彦淖尔市美溪区安仁路181号金色家园', 13953644999, '');
INSERT INTO `vendor` VALUES (235781881, '231947', '瀚新', '吉林省保山市榆次区安化路13号阳光翠竹苑', 13847513742, '');

-- ----------------------------
-- Function structure for BOOL检查商家账号密码（可用手机号做账号）
-- ----------------------------
DROP FUNCTION IF EXISTS `BOOL检查商家账号密码（可用手机号做账号）`;
delimiter ;;
CREATE FUNCTION `BOOL检查商家账号密码（可用手机号做账号）`(id BIGINT, pwd VARCHAR(255))
 RETURNS binary(1)
  READS SQL DATA 
BEGIN
		SET @A = ((SELECT vendor.vendor_password FROM vendor WHERE vendor.vendor_id = id) = pwd);
		SET @B = (IF(@A = 1, 1, 0));
		SET @C = ((SELECT vendor.vendor_password FROM vendor WHERE vendor.vendor_phone = id) = pwd);
		SET @D = (IF(@C = 1, 1, 0));
		SET @E = (IF(@B = 1 OR @D = 1, 1, 0));
		RETURN @E;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for BOOL检查用户账号密码（可用手机号做账号）
-- ----------------------------
DROP FUNCTION IF EXISTS `BOOL检查用户账号密码（可用手机号做账号）`;
delimiter ;;
CREATE FUNCTION `BOOL检查用户账号密码（可用手机号做账号）`(id BIGINT, pwd VARCHAR(255))
 RETURNS binary(1)
  READS SQL DATA 
BEGIN
		SET @A = ((SELECT users.`password` FROM users WHERE users.consumer_id = id) = pwd);
		SET @B = (IF(@A = 1, 1, 0));
		SET @C = ((SELECT users.`password` FROM users WHERE users.phone_number = id) = pwd);
		SET @D = (IF(@C = 1, 1, 0));
		SET @E = (IF(@B = 1 OR @D = 1, 1, 0));
		RETURN @E;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cart-使用购物车创建订单
-- ----------------------------
DROP PROCEDURE IF EXISTS `cart-使用购物车创建订单`;
delimiter ;;
CREATE PROCEDURE `cart-使用购物车创建订单`(`uid` int, addr VARCHAR(255), PHONE BIGINT)
BEGIN
set @order_id=`order-MAKE_AN_EMPTY_ORDER`(uid, addr, PHONE);
INSERT INTO purchase_relations (purchase_relations.order_id, purchase_relations.goods_id, purchase_relations.goods_number, purchase_relations.goods_type_id, purchase_relations.actually_paid_money) SELECT @order_id, cart.goods_id, cart.goods_number, cart.goods_type_id, cart.actually_money  FROM cart WHERE cart.user_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cart-修改购物车某商品的数量
-- ----------------------------
DROP PROCEDURE IF EXISTS `cart-修改购物车某商品的数量`;
delimiter ;;
CREATE PROCEDURE `cart-修改购物车某商品的数量`(`uid` bigint,`gid` bigint, `num` int)
BEGIN
	#Routine body goes here...
	UPDATE cart SET cart.goods_number=num WHERE cart.user_id=uid AND cart.goods_id=gid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cart-删除购物车的某个商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `cart-删除购物车的某个商品`;
delimiter ;;
CREATE PROCEDURE `cart-删除购物车的某个商品`(`uid` bigint,`gid` bigint)
BEGIN
	DELETE FROM cart WHERE cart.goods_id=gid AND cart.user_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cart-直接删除某个用户购物车中所有商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `cart-直接删除某个用户购物车中所有商品`;
delimiter ;;
CREATE PROCEDURE `cart-直接删除某个用户购物车中所有商品`(`uid` bigint)
BEGIN
	#Routine body goes here...
	DELETE FROM cart WHERE cart.user_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for comments_media_url_用户向评论中添加一个图片或视频的url
-- ----------------------------
DROP PROCEDURE IF EXISTS `comments_media_url_用户向评论中添加一个图片或视频的url`;
delimiter ;;
CREATE PROCEDURE `comments_media_url_用户向评论中添加一个图片或视频的url`(purchase_id BIGINT, url VARCHAR(255))
BEGIN
	#Routine body goes here...
	INSERT INTO comments_media_url SET comments_media_url.purchase_id=purchase_id, comments_media_url.url=url;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for goods&goods_type&cart-向购物车中添加不含型号商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods&goods_type&cart-向购物车中添加不含型号商品`;
delimiter ;;
CREATE PROCEDURE `goods&goods_type&cart-向购物车中添加不含型号商品`(uid BIGINT,gid BIGINT,nums DECIMAL(4,2),disc DECIMAL(4,2))
BEGIN
	#Routine body goes here...
		INSERT INTO cart SET cart.discount=disc,cart.goods_id=gid,cart.goods_number=nums,cart.user_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for goods&goods_type&cart-向购物车中添加含型号商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods&goods_type&cart-向购物车中添加含型号商品`;
delimiter ;;
CREATE PROCEDURE `goods&goods_type&cart-向购物车中添加含型号商品`(uid BIGINT,tid BIGINT,gid BIGINT,nums INT,disc DECIMAL(4,2))
BEGIN
	#Routine body goes here...
		INSERT INTO cart SET cart.discount=disc,cart.goods_id=gid,cart.goods_number=nums,cart.goods_type_id=tid,cart.user_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for goods&goods_type-商家为某商品添加属于某商品的型号
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods&goods_type-商家为某商品添加属于某商品的型号`;
delimiter ;;
CREATE PROCEDURE `goods&goods_type-商家为某商品添加属于某商品的型号`(gid BIGINT, tname VARCHAR(255), url VARCHAR(255))
BEGIN
INSERT INTO goods_type SET goods_type.goods_id=gid,goods_type.goods_type_name=tname,goods_type.type_media_url=url; 
	#Routine body goes here...
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for goods-商家上架一款商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods-商家上架一款商品`;
delimiter ;;
CREATE PROCEDURE `goods-商家上架一款商品`(vend BIGINT, nam VARCHAR(255), descri VARCHAR(255), pr DECIMAL(10,2), danwei VARCHAR(255), amt DECIMAL(10,2))
BEGIN
	#Routine body goes here...
	INSERT goods SET goods.vendor_id=vend, goods.goods_name=nam, goods.goods_describe=descri, goods.price=pr, goods.unit=danwei, goods.amount=amt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for goods-商家修改商品信息
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods-商家修改商品信息`;
delimiter ;;
CREATE PROCEDURE `goods-商家修改商品信息`(nam VARCHAR(255), descri VARCHAR(255), pr DECIMAL(10,2), danwei VARCHAR(255), amt DECIMAL(10,2))
BEGIN
	UPDATE goods SET goods.amount=amt,goods.goods_describe=descri,goods.unit=danwei,goods.goods_name=nam,goods.price=pr;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for goods-商家删除某个商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods-商家删除某个商品`;
delimiter ;;
CREATE PROCEDURE `goods-商家删除某个商品`(gid BIGINT)
BEGIN
	DELETE FROM goods WHERE goods.goods_id=gid;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for goods_media_url-商家向某个商品中添加图片视频URL
-- ----------------------------
DROP PROCEDURE IF EXISTS `goods_media_url-商家向某个商品中添加图片视频URL`;
delimiter ;;
CREATE PROCEDURE `goods_media_url-商家向某个商品中添加图片视频URL`(gid BIGINT, url varchar(255))
BEGIN
	#Routine body goes here...
		INSERT INTO goods_media_url SET goods_media_url.goods_id=gid, goods_media_url.url=url;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for order-MAKE_AN_EMPTY_ORDER
-- ----------------------------
DROP FUNCTION IF EXISTS `order-MAKE_AN_EMPTY_ORDER`;
delimiter ;;
CREATE FUNCTION `order-MAKE_AN_EMPTY_ORDER`(uid BIGINT, addr VARCHAR(255), PHONE BIGINT)
 RETURNS bigint
  READS SQL DATA 
BEGIN
		DECLARE rnd BIGINT UNSIGNED; 
		r: REPEAT
		SET rnd = ROUND(10000000+(rand()*90000000));
		UNTIL NOT EXISTS( SELECT 1 FROM `order` WHERE `order`.order_id = rnd ) END REPEAT r; 	
		INSERT INTO `order` SET `order`.consumer_id=uid, `order`.shipping_address=addr, `order`.shipping_phone_number=phone, `order`.order_id=rnd;
		RETURN rnd;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-使用一个含型号商品直接创建某用户的订单
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-使用一个含型号商品直接创建某用户的订单`;
delimiter ;;
CREATE PROCEDURE `order-使用一个含型号商品直接创建某用户的订单`(TYPEID BIGINT, GOODSID BIGINT, `uid` int, addr VARCHAR(255), PHONE BIGINT)
BEGIN
	#Routine body goes here...
	set @order_id=`order-MAKE_AN_EMPTY_ORDER`(uid, addr, PHONE);
	INSERT INTO purchase_relations SET purchase_relations.goods_id=GOODSID, purchase_relations.goods_type_id=TYPEID,purchase_relations.order_id=@order_id, purchase_relations.actually_paid_money=(SELECT goods.price FROM goods WHERE goods.goods_id=GOODSID);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-使用一个无型号商品直接创建某用户的订单
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-使用一个无型号商品直接创建某用户的订单`;
delimiter ;;
CREATE PROCEDURE `order-使用一个无型号商品直接创建某用户的订单`(GOODSID BIGINT, `uid` int, addr VARCHAR(255), PHONE BIGINT, discount DECIMAL(10,2))
BEGIN
	#Routine body goes here...
	set @order_id=`order-MAKE_AN_EMPTY_ORDER`(uid, addr, PHONE);
	set @pc=(SELECT goods.price FROM goods WHERE goods.goods_id=GOODSID)*discount;
	INSERT INTO purchase_relations SET purchase_relations.goods_id=GOODSID,purchase_relations.order_id=@order_id, purchase_relations.actually_paid_money=@pc;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-商家于用户商品状态操作
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-商家于用户商品状态操作`;
delimiter ;;
CREATE PROCEDURE `order-商家于用户商品状态操作`(pid BIGINT, goalstatus INT)
BEGIN
	UPDATE purchase_relations SET purchase_relations.user_goods_status=goalstatus WHERE purchase_relations.purchase_id=pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-商家填写物流单号
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-商家填写物流单号`;
delimiter ;;
CREATE PROCEDURE `order-商家填写物流单号`(pid BIGINT, express VARCHAR(255))
BEGIN
	UPDATE purchase_relations SET purchase_relations.express_number=express WHERE purchase_relations.purchase_id=pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-用户于订单状态操作
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-用户于订单状态操作`;
delimiter ;;
CREATE PROCEDURE `order-用户于订单状态操作`(oid BIGINT, goalstatus INT)
BEGIN
	#Routine body goes here...
	UPDATE `order` SET `order`.order_status=goalstatus WHERE `order`.order_id=oid;
	UPDATE purchase_relations SET purchase_relations.user_goods_status=goalstatus WHERE purchase_relations.order_id=oid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-用户修改订单收货地址
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-用户修改订单收货地址`;
delimiter ;;
CREATE PROCEDURE `order-用户修改订单收货地址`(orderid BIGINT, addr VARCHAR(255))
BEGIN
	UPDATE `order` SET `order`.shipping_address=addr WHERE `order`.order_id=orderid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-用户修改订单电话号码
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-用户修改订单电话号码`;
delimiter ;;
CREATE PROCEDURE `order-用户修改订单电话号码`(orderid BIGINT, phone BIGINT)
BEGIN
	UPDATE `order` SET `order`.shipping_phone_number=phone WHERE `order`.order_id=orderid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for order-用户填写退货单号
-- ----------------------------
DROP PROCEDURE IF EXISTS `order-用户填写退货单号`;
delimiter ;;
CREATE PROCEDURE `order-用户填写退货单号`(pid BIGINT, express VARCHAR(255))
BEGIN
	UPDATE purchase_relations SET purchase_relations.return_express_number=express WHERE purchase_relations.purchase_id=pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for purchase-用户上传一条某商品评论
-- ----------------------------
DROP PROCEDURE IF EXISTS `purchase-用户上传一条某商品评论`;
delimiter ;;
CREATE PROCEDURE `purchase-用户上传一条某商品评论`(purid BIGINT, commentstr VARCHAR(255))
BEGIN
	UPDATE purchase_relations SET purchase_relations.comments=commentstr WHERE purchase_relations.purchase_id=purid;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for purchase-用户于单商品状态操作
-- ----------------------------
DROP PROCEDURE IF EXISTS `purchase-用户于单商品状态操作`;
delimiter ;;
CREATE PROCEDURE `purchase-用户于单商品状态操作`(pid BIGINT, goalstatus INT)
BEGIN
	UPDATE purchase_relations SET purchase_relations.user_goods_status=goalstatus WHERE purchase_relations.purchase_id=pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for purchase-用户对一条某商品评分
-- ----------------------------
DROP PROCEDURE IF EXISTS `purchase-用户对一条某商品评分`;
delimiter ;;
CREATE PROCEDURE `purchase-用户对一条某商品评分`(purid BIGINT, score DECIMAL(10,2))
BEGIN
	UPDATE purchase_relations SET purchase_relations.score=score WHERE purchase_relations.purchase_id=purid;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for users-修改一个用户的信息
-- ----------------------------
DROP PROCEDURE IF EXISTS `users-修改一个用户的信息`;
delimiter ;;
CREATE PROCEDURE `users-修改一个用户的信息`(username VARCHAR(255), phone BIGINT, sex INT, bthdy DATE, nick VARCHAR(255), pwd VARCHAR(255), icon VARCHAR(255))
BEGIN
		UPDATE users SET users.consumer_name=username, users.phone_number=phone, users.gender=sex, users.birthday=bthdy, users.consumer_nickname=nick, users.`password`=pwd, users.costumer_icon_url=icon;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for users-创建一个新用户
-- ----------------------------
DROP PROCEDURE IF EXISTS `users-创建一个新用户`;
delimiter ;;
CREATE PROCEDURE `users-创建一个新用户`(phone BIGINT, pwd VARCHAR(255))
BEGIN
		INSERT INTO users SET users.phone_number=phone, users.`password`=pwd;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for users-检查用户账号密码（可用手机号做账号）
-- ----------------------------
DROP PROCEDURE IF EXISTS `users-检查用户账号密码（可用手机号做账号）`;
delimiter ;;
CREATE PROCEDURE `users-检查用户账号密码（可用手机号做账号）`(`uid` VARCHAR(255),`pwd` VARCHAR(255))
BEGIN
	SELECT users.consumer_id FROM users WHERE (users.consumer_id=uid AND users.`password`=pwd) OR (users.phone_number=uid AND users.`password`=pwd);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for users-注销一个用户
-- ----------------------------
DROP PROCEDURE IF EXISTS `users-注销一个用户`;
delimiter ;;
CREATE PROCEDURE `users-注销一个用户`(userid BIGINT)
BEGIN
	DELETE FROM	users WHERE users.consumer_id=userid;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for vendor-修改商家信息
-- ----------------------------
DROP PROCEDURE IF EXISTS `vendor-修改商家信息`;
delimiter ;;
CREATE PROCEDURE `vendor-修改商家信息`(id BIGINT, pwd BIGINT, nam VARCHAR(255), addr VARCHAR(255), phone BIGINT, icon VARCHAR(255))
BEGIN
	UPDATE vendor SET vendor.vendor_password=pwd, vendor.vendor_name=nam, vendor.vendor_addr=addr, vendor.vendor_phone=phone, vendor.vendor_icon_url=icon WHERE vendor.vendor_id=id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for vendor-创建商家
-- ----------------------------
DROP PROCEDURE IF EXISTS `vendor-创建商家`;
delimiter ;;
CREATE PROCEDURE `vendor-创建商家`(pwd BIGINT, nam VARCHAR(255), addr VARCHAR(255), phone BIGINT, icon VARCHAR(255))
BEGIN
	INSERT INTO vendor SET vendor.vendor_password=pwd, vendor.vendor_name=nam, vendor.vendor_addr=addr, vendor.vendor_phone=phone, vendor.vendor_icon_url=icon;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for vendor-检查商家账号密码（可用手机号做账号）
-- ----------------------------
DROP PROCEDURE IF EXISTS `vendor-检查商家账号密码（可用手机号做账号）`;
delimiter ;;
CREATE PROCEDURE `vendor-检查商家账号密码（可用手机号做账号）`(`uid` VARCHAR(255),`pwd` VARCHAR(255))
BEGIN
	SELECT vendor.vendor_id FROM vendor WHERE (vendor.vendor_id=uid AND vendor.vendor_password=pwd) OR (vendor.vendor_phone=uid AND vendor.vendor_password=pwd);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for vendor-注销商家
-- ----------------------------
DROP PROCEDURE IF EXISTS `vendor-注销商家`;
delimiter ;;
CREATE PROCEDURE `vendor-注销商家`(id BIGINT)
BEGIN
	DELETE FROM vendor WHERE vendor.vendor_id=id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 按ID查询商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `按ID查询商品`;
delimiter ;;
CREATE PROCEDURE `按ID查询商品`(gid BIGINT)
BEGIN
SELECT goods.* FROM goods WHERE goods.goods_id=gid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 按ID查询用户
-- ----------------------------
DROP PROCEDURE IF EXISTS `按ID查询用户`;
delimiter ;;
CREATE PROCEDURE `按ID查询用户`(uid BIGINT)
BEGIN
SELECT users.* FROM users WHERE users.consumer_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 按名称查询用户
-- ----------------------------
DROP PROCEDURE IF EXISTS `按名称查询用户`;
delimiter ;;
CREATE PROCEDURE `按名称查询用户`(ipt VARCHAR(255))
BEGIN
SELECT users.* FROM users WHERE users.consumer_name like CONCAT('%',ipt,'%') or users.consumer_nickname like CONCAT('%',ipt,'%');
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 按商品名称查询商品库里商品的描述与首张图
-- ----------------------------
DROP PROCEDURE IF EXISTS `按商品名称查询商品库里商品的描述与首张图`;
delimiter ;;
CREATE PROCEDURE `按商品名称查询商品库里商品的描述与首张图`(ipt VARCHAR(255), paixv_condition VARCHAR(255), paixv_method VARCHAR(255))
BEGIN
IF paixv_condition='SCORE' THEN
	IF paixv_method='DESC' THEN
		SELECT goods.* FROM goods
		WHERE goods.goods_describe like CONCAT('%',ipt,'%') or goods.goods_name like CONCAT('%',ipt,'%') ORDER BY goods.goods_score DESC;
	ELSE
		SELECT goods.* FROM goods
		WHERE goods.goods_describe like CONCAT('%',ipt,'%') or goods.goods_name like CONCAT('%',ipt,'%') ORDER BY goods.goods_score ASC;
	END IF;
ELSE
	IF paixv_method='DESC' THEN
		SELECT goods.* FROM goods
		WHERE goods.goods_describe like CONCAT('%',ipt,'%') or goods.goods_name like CONCAT('%',ipt,'%') ORDER BY goods.price DESC;
	ELSE
		SELECT goods.* FROM goods
		WHERE goods.goods_describe like CONCAT('%',ipt,'%') or goods.goods_name like CONCAT('%',ipt,'%') ORDER BY goods.price ASC;
	END IF;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询所有的商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询所有的商品`;
delimiter ;;
CREATE PROCEDURE `查询所有的商品`()
BEGIN
SELECT goods.* FROM goods;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询所有的用户
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询所有的用户`;
delimiter ;;
CREATE PROCEDURE `查询所有的用户`()
BEGIN
SELECT users.* FROM users;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某个商家所有商品的描述与首张图
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某个商家所有商品的描述与首张图`;
delimiter ;;
CREATE PROCEDURE `查询某个商家所有商品的描述与首张图`(vid BIGINT, paixv_condition VARCHAR(255), paixv_method VARCHAR(255))
BEGIN
IF paixv_condition='SCORE' THEN
	IF paixv_method='DESC' THEN
		SELECT goods.* FROM goods
		WHERE goods.vendor_id=vid ORDER BY goods.goods_score DESC;
	ELSE
		SELECT goods.* FROM goods
		WHERE goods.vendor_id=vid ORDER BY goods.goods_score ASC;
	END IF;
ELSE
	IF paixv_method='DESC' THEN
		SELECT goods.* FROM goods
		WHERE goods.vendor_id=vid ORDER BY goods.price DESC;
	ELSE
		SELECT goods.* FROM goods
		WHERE goods.vendor_id=vid ORDER BY goods.price ASC;
	END IF;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某商品所有型号详细信息
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某商品所有型号详细信息`;
delimiter ;;
CREATE PROCEDURE `查询某商品所有型号详细信息`(gid BIGINT)
BEGIN
SELECT goods_type.goods_type_id, goods_type.goods_type_name, goods_type.type_media_url 
FROM goods_type WHERE goods_type.goods_id=gid ORDER BY goods_type.in_group_id ASC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某商品的图片视频
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某商品的图片视频`;
delimiter ;;
CREATE PROCEDURE `查询某商品的图片视频`(gid BIGINT)
BEGIN
SELECT
goods_media_url.media_id,
goods_media_url.url
FROM
goods_media_url
WHERE
goods_media_url.goods_id=gid
ORDER BY goods_media_url.in_group_id ASC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某商品的所有文字信息
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某商品的所有文字信息`;
delimiter ;;
CREATE PROCEDURE `查询某商品的所有文字信息`(gid BIGINT)
BEGIN
SELECT goods.* FROM goods WHERE goods.goods_id=gid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某商品的所有文字评论
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某商品的所有文字评论`;
delimiter ;;
CREATE PROCEDURE `查询某商品的所有文字评论`(gid BIGINT)
BEGIN
SELECT purchase_relations.comments FROM purchase_relations WHERE purchase_relations.goods_id=gid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某商家特定状态的交易列表
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某商家特定状态的交易列表`;
delimiter ;;
CREATE PROCEDURE `查询某商家特定状态的交易列表`(vid BIGINT, stat INT)
BEGIN
IF stat=-1 THEN
	SELECT
		purchase_relations.*
	FROM
		goods
		INNER JOIN
		purchase_relations
		ON 
			goods.goods_id = purchase_relations.goods_id
	WHERE
		goods.vendor_id = vid;
ELSE
	SELECT
		purchase_relations.*
	FROM
		goods
		INNER JOIN
		purchase_relations
		ON 
			goods.goods_id = purchase_relations.goods_id
	WHERE
		goods.vendor_id = vid AND purchase_relations.user_goods_status=stat;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某用户特定状态的订单
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某用户特定状态的订单`;
delimiter ;;
CREATE PROCEDURE `查询某用户特定状态的订单`(uid BIGINT, stat INT)
BEGIN
	IF stat=-1 THEN
		SELECT `order`.* FROM `order` WHERE `order`.consumer_id=uid;
	ELSE
		SELECT `order`.* FROM `order` WHERE `order`.consumer_id=uid AND `order`.order_status=stat;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某用户的信息
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某用户的信息`;
delimiter ;;
CREATE PROCEDURE `查询某用户的信息`(uid BIGINT)
BEGIN
SELECT users.* FROM users WHERE users.consumer_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某用户的购物车内容
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某用户的购物车内容`;
delimiter ;;
CREATE PROCEDURE `查询某用户的购物车内容`(uid BIGINT)
BEGIN
SELECT
	*
FROM
	cart
	INNER JOIN
	goods
	ON 
		cart.goods_id = goods.goods_id
	WHERE cart.user_id=uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某订单的详细信息
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某订单的详细信息`;
delimiter ;;
CREATE PROCEDURE `查询某订单的详细信息`(oid BIGINT)
BEGIN
SELECT
	`order`.*, 
	purchase_relations.purchase_id, 
	purchase_relations.goods_id, 
	purchase_relations.goods_type_id, 
	purchase_relations.goods_number, 
	purchase_relations.user_goods_status, 
	purchase_relations.actually_paid_money, 
	purchase_relations.comments, 
	purchase_relations.score, 
	purchase_relations.express_number, 
	purchase_relations.return_express_number
FROM
	`order`
	LEFT JOIN
	purchase_relations
	ON 
		`order`.order_id = purchase_relations.order_id
WHERE
	`order`.order_id=oid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 查询某评论的图片视频
-- ----------------------------
DROP PROCEDURE IF EXISTS `查询某评论的图片视频`;
delimiter ;;
CREATE PROCEDURE `查询某评论的图片视频`(pid BIGINT)
BEGIN
SELECT
comments_media_url.media_id,
comments_media_url.url
FROM
comments_media_url
WHERE
comments_media_url.purchase_id=pid
ORDER BY comments_media_url.in_group_id ASC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for 随机推送某数量商品
-- ----------------------------
DROP PROCEDURE IF EXISTS `随机推送某数量商品`;
delimiter ;;
CREATE PROCEDURE `随机推送某数量商品`(num INT)
BEGIN
	SELECT goods.* FROM goods
	ORDER BY RAND() LIMIT num;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table cart
-- ----------------------------
DROP TRIGGER IF EXISTS `ill_check`;
delimiter ;;
CREATE TRIGGER `ill_check` AFTER UPDATE ON `cart` FOR EACH ROW BEGIN
DECLARE msg VARCHAR(255);
SET @remain = (SELECT goods.amount FROM goods WHERE goods.goods_id=new.goods_id);
IF new.goods_number>@remain or new.goods_number<1 THEN
	set msg = "数量非法";
	SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table cart
-- ----------------------------
DROP TRIGGER IF EXISTS `cart_mach`;
delimiter ;;
CREATE TRIGGER `cart_mach` BEFORE INSERT ON `cart` FOR EACH ROW BEGIN
DECLARE tmp DECIMAL(10,2);
DECLARE msg VARCHAR(255);
DECLARE rnd INT;
r: REPEAT
SET rnd = ROUND(10000000+(rand()*90000000));
UNTIL NOT EXISTS( SELECT 1 FROM `goods` WHERE goods.goods_id = rnd ) END REPEAT r; 	
SET new.out_cart_id = rnd;
SET tmp=(SELECT goods.price FROM goods WHERE goods.goods_id=new.goods_id);
SET new.actually_money = new.discount*tmp*new.goods_number;
SET @remain = (SELECT goods.amount FROM goods WHERE goods.goods_id=new.goods_id);
IF new.goods_number>@remain or new.goods_number<1 THEN
	set msg = "数量非法";
	SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table comments_media_url
-- ----------------------------
DROP TRIGGER IF EXISTS `comments_service`;
delimiter ;;
CREATE TRIGGER `comments_service` BEFORE INSERT ON `comments_media_url` FOR EACH ROW BEGIN
		 DECLARE ans INT; 
     SET new.media_id = UUID();
		 SET ans=(SELECT COUNT(*) FROM comments_media_url WHERE comments_media_url.purchase_id=new.purchase_id);
		 SET new.in_group_id = (ans+1);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table goods
-- ----------------------------
DROP TRIGGER IF EXISTS `illegal_trigger`;
delimiter ;;
CREATE TRIGGER `illegal_trigger` AFTER UPDATE ON `goods` FOR EACH ROW BEGIN
DECLARE msg VARCHAR(255);
IF new.amount<0 THEN
set msg = "剩余量不足";
SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table goods
-- ----------------------------
DROP TRIGGER IF EXISTS `goods_id_trigger`;
delimiter ;;
CREATE TRIGGER `goods_id_trigger` BEFORE INSERT ON `goods` FOR EACH ROW BEGIN
DECLARE rnd BIGINT UNSIGNED; 
DECLARE msg VARCHAR(255);
IF new.amount<1 THEN
	set msg = "数量非法";
	SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
	END IF;
r: REPEAT
SET rnd = ROUND(10000000+(rand()*90000000));
UNTIL NOT EXISTS( SELECT 1 FROM `goods` WHERE goods.goods_id = rnd ) END REPEAT r; 	
SET new.goods_id = rnd;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table goods_media_url
-- ----------------------------
DROP TRIGGER IF EXISTS `ne`;
delimiter ;;
CREATE TRIGGER `ne` BEFORE INSERT ON `goods_media_url` FOR EACH ROW BEGIN
DECLARE rnd BIGINT UNSIGNED;
DECLARE ingrno INT; 
r: REPEAT
SET rnd = ROUND(10000000+(rand()*90000000));
UNTIL NOT EXISTS( SELECT 1 FROM `goods_media_url` WHERE goods_media_url.media_id = rnd ) END REPEAT r; 	
SET new.media_id = rnd;
		 SET ingrno=(SELECT COUNT(*) FROM goods_media_url WHERE goods_media_url.goods_id=new.goods_id);
		 SET new.in_group_id = (ingrno+1);
		 IF new.in_group_id=1 THEN
		 UPDATE goods SET goods.head_photo=new.url WHERE goods.goods_id=new.goods_id;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table goods_type
-- ----------------------------
DROP TRIGGER IF EXISTS `goods_type_id_trigger`;
delimiter ;;
CREATE TRIGGER `goods_type_id_trigger` BEFORE INSERT ON `goods_type` FOR EACH ROW BEGIN
DECLARE rnd BIGINT UNSIGNED; 
DECLARE ingrnoa INT;
r: REPEAT
SET rnd = ROUND(10000000+(rand()*90000000));
UNTIL NOT EXISTS( SELECT 1 FROM `goods_type` WHERE goods_type.goods_type_id = rnd ) END REPEAT r; 	
SET new.goods_type_id = rnd;
		 SET ingrnoa=(SELECT COUNT(*) FROM goods_type WHERE goods_type.goods_id=new.goods_id);
		 SET new.in_group_id = (ingrnoa+1);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table purchase_relations
-- ----------------------------
DROP TRIGGER IF EXISTS `purchase_update_trigger`;
delimiter ;;
CREATE TRIGGER `purchase_update_trigger` AFTER UPDATE ON `purchase_relations` FOR EACH ROW BEGIN
DECLARE tmp_score DECIMAL(10,2);
DECLARE userid INT;
DECLARE msg VARCHAR(255);
IF new.goods_number<0 THEN
	set msg = "数量非法";
	SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
	END IF;
SET tmp_score=(SELECT AVG(purchase_relations.score) FROM purchase_relations WHERE new.goods_id=purchase_relations.goods_id);
SET userid=(SELECT `order`.consumer_id FROM `order` WHERE `order`.order_id=new.order_id);
UPDATE users SET users.exp=(users.exp+1) WHERE users.consumer_id=userid;
UPDATE goods SET goods.goods_score=tmp_score WHERE goods.goods_id=new.goods_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table purchase_relations
-- ----------------------------
DROP TRIGGER IF EXISTS `purchase_trigger`;
delimiter ;;
CREATE TRIGGER `purchase_trigger` BEFORE INSERT ON `purchase_relations` FOR EACH ROW BEGIN
DECLARE rnd BIGINT UNSIGNED; 
DECLARE msg VARCHAR(255);
IF new.goods_number<0 THEN
	set msg = "数量非法";
	SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = msg;
	END IF;
r: REPEAT
SET rnd = ROUND(10000000+(rand()*90000000));
UNTIL NOT EXISTS( SELECT 1 FROM `purchase_relations` WHERE purchase_relations.purchase_id = rnd ) END REPEAT r; 	
SET new.purchase_id = rnd;
UPDATE goods SET goods.amount=(goods.amount-new.goods_number) WHERE goods.goods_id=new.goods_id;
UPDATE `order` SET `order`.total_order_price=(`order`.total_order_price+new.actually_paid_money) WHERE `order`.order_id=new.order_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table users
-- ----------------------------
DROP TRIGGER IF EXISTS `usermach`;
delimiter ;;
CREATE TRIGGER `usermach` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
DECLARE rnd BIGINT UNSIGNED; 
r: REPEAT
SET rnd = ROUND(10000000+(rand()*90000000));
UNTIL NOT EXISTS( SELECT 1 FROM `users` WHERE users.consumer_id = rnd ) END REPEAT r; 	
SET new.consumer_id = rnd;
SET new.consumer_nickname = UUID();
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table vendor
-- ----------------------------
DROP TRIGGER IF EXISTS `vendma`;
delimiter ;;
CREATE TRIGGER `vendma` BEFORE INSERT ON `vendor` FOR EACH ROW BEGIN
DECLARE rnd BIGINT UNSIGNED; 
r: REPEAT
SET rnd = ROUND(10000000+(rand()*90000000));
UNTIL NOT EXISTS( SELECT 1 FROM `users` WHERE users.consumer_id = rnd ) END REPEAT r; 	
SET new.vendor_id = rnd;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
