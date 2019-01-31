SET NAMES UTF8;
DROP DATABASE IF EXISTS xfn;
CREATE DATABASE xfn CHARSET=UTF8;
USE xfn;

-- 管理员信息表
CREATE TABLE xfn_admin(
    aid INT PRIMARY KEY AUTO_INCREMENT,  -- 管理员编号
    aname VARCHAR(32) UNIQUE,     -- 管理员用户名
    apwd VARCHAR(64)              -- 管理员密码
);
INSERT INTO xfn_admin VALUES
(NULL,'admin',PASSWORD('123456')),
(NULL,'boss',PASSWORD('999999'));

-- 项目全局设置
CREATE TABLE xfn_setting(
    sid INT PRIMARY KEY AUTO_INCREMENT,  -- 编号
    appName VARCHAR(64),          -- 应用名称
    apiUrl VARCHAR(64),           -- 数据API子系统地址
    adminUrl varchar(64),         -- 管理子系统地址
    appUrl VARCHAR(64),           -- 顾客App子系统地址
    icp VARCHAR(64),              -- 系统备案信息
    copyright  VARCHAR(128)       -- 系统版权信息
);
INSERT INTO xfn_setting VALUES
(NULL,'小肥牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备12003709号-3','北京达内金桥科技有限公司版权所有');

-- 桌台信息表
CREATE TABLE xfn_table(
    tid INT PRIMARY KEY AUTO_INCREMENT,  -- 桌台编号
    tname VARCHAR(64) DEFAULT NULL,      -- 别称
    ttype VARCHAR(16),                   -- 类型，如3-4人桌
    tstatus INT        -- 当前状态 0-其他 1-空闲 2-预定 3-占用
);
INSERT INTO xfn_table VALUES
(NULL, '金镶玉', '2人桌', 1),
(NULL, '玉如意', '2人桌', 1),
(NULL, '齐天寿', '6人桌', 3),
(NULL, '福临门', '4人桌', 2),
(NULL, '全家福', '6人桌', 3),
(NULL, '展宏图', '2人桌', 1),
(NULL, '万年长', '8人桌', 1),
(NULL, '百事通', '4人桌', 3),
(NULL, '满堂彩', '10人桌', 2),
(NULL, '鸿运头', '8人桌', 1),
(NULL, '福满堂', '12人桌', 1),
(NULL, '高升阁', '4人桌', 3),
(NULL, '乐逍遥', '2人桌',3);

-- 桌台预定信息表
CREATE TABLE xfn_reservation(
    rid INT PRIMARY KEY AUTO_INCREMENT, -- 信息编号
    contactName VARCHAR(64),            -- 联系人姓名
    phone VARCHAR(16),                  -- 联系人电话
    contactTime BIGINT,                 -- 联系时间
    dinnerTime BIGINT                   -- 预约的用餐时间
    tableId INT,                        -- 预定的桌台号
    FOREIGN KEY(tableId) REFERENCES xfn_table(tid)  --设置外键
);
INSERT INTO xfn_reservation VALUES 
(NULL,'张三','13855854955',1548404810420,1548410400000),
(NULL,'丁丁','13855854955',1548404820420,1548410400000),
(NULL,'当当','13855854955',1548404830420,1548410400000),
(NULL,'凉凉','13855854955',1548404840420,1548410400000);

-- 菜品分类表
CREATE TABLE xfn_category(
    cid INT PRIMARY KEY AUTO_INCREMENT, -- 类别编号
    cname VARCHAR(32)                   -- 类别名称
);
INSERT INTO xfn_category VALUES
(NULL,'肉类'),
(NULL,'丸滑类'),
(NULL,'海鲜类'),
(NULL,'蔬菜豆制品'),
(NULL,'菌菇类');


-- 菜品信息表
CREATE TABLE xfn_dish(
    did INT PRIMARY KEY AUTO_INCREMENT, -- 菜品编号从10000开始
    title VARCHAR(32),                  -- 菜品名称/标题
    imgUrl VARCHAR(128),                -- 图片地址
    price DECIMAL(6,2),                 -- 菜品价格
    detail VARCHAR(128),                -- 详细描述信息
    categoryId INT,                     -- 所属类别的编号
    FOREIGN KEY(categoryId) REFERENCES xfn_category(cid)
);
INSERT INTO xfn_dish VALUES
(100000,'草鱼片','CE7I9470.jpg',35,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用。',1),
(NULL,'脆皮肠','CE7I9017.jpg',25,'锅开后再煮3分钟左右即可食用。',1),
(NULL,'酥肉','HGS4760.jpg',30,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮3分钟左右即可食用。',1),
(NULL,'牛百叶','CE7I9302.jpg',28,'毛肚切丝后，配以调味料腌制而成。锅开后再煮2分钟左右即可食用。',1);

-- 订单表
CREATE TABLE xfn_order(
    oid INT PRIMARY KEY AUTO_INCREMENT,
    startTime BIGINT,   -- 开始用餐时间
    endTime BIGINT,     -- 结束用餐时间
    customerCount INT,  -- 用餐人数
    tableId INT,        -- 桌台编号，指明所属桌台 
    FOREIGN KEY(tableId) REFERENCES xfn_table(tid)  -- 外键 参考桌台tid  桌台编号
);
INSERT INTO xfn_order VALUES
(NULL,1548404948807,1548406948807,3,1);

-- 订单详情
CREATE TABLE xfn_order_detail(
    did INT PRIMARY KEY AUTO_INCREMENT, -- 订单编号
    dishId INT,                 -- 菜品编号
    dishCount INT,              -- 菜品数量
    customerName VARCHAR(64),   -- 点餐用户的称呼
    orderId INT,               -- 订单编号
    FOREIGN KEY(dishId) REFERENCES xfn_dish(did), -- 设置外键
    FOREIGN KEY(orderId) REFERENCES xfn_order(oid) -- 设置外键
);
INSERT INTO xfn_order_detail VALUES
(NULL,100000,1,'张三',1);