/*
 Navicat Premium Dump SQL

 Source Server         : 192.168.56.128-mysql
 Source Server Type    : MySQL
 Source Server Version : 90300 (9.3.0)
 Source Host           : 192.168.56.128:3306
 Source Schema         : ruoyi-vue-pro

 Target Server Type    : MySQL
 Target Server Version : 90300 (9.3.0)
 File Encoding         : 65001

 Date: 21/06/2025 16:12:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for infra_api_access_log
-- ----------------------------
DROP TABLE IF EXISTS `infra_api_access_log`;
CREATE TABLE `infra_api_access_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `application_name` varchar(50) NOT NULL COMMENT '应用名',
  `request_method` varchar(16) NOT NULL DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) NOT NULL DEFAULT '' COMMENT '请求地址',
  `request_params` text NULL COMMENT '请求参数',
  `response_body` text NULL COMMENT '响应结果',
  `user_ip` varchar(50) NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) NOT NULL COMMENT '浏览器 UA',
  `operate_module` varchar(50) NULL DEFAULT NULL COMMENT '操作模块',
  `operate_name` varchar(50) NULL DEFAULT NULL COMMENT '操作名',
  `operate_type` tinyint NULL DEFAULT 0 COMMENT '操作分类',
  `begin_time` datetime NOT NULL COMMENT '开始请求时间',
  `end_time` datetime NOT NULL COMMENT '结束请求时间',
  `duration` int NOT NULL COMMENT '执行时长',
  `result_code` int NOT NULL DEFAULT 0 COMMENT '结果码',
  `result_msg` varchar(512) NULL DEFAULT '' COMMENT '结果提示',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35953 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'API 访问日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_api_access_log
-- ----------------------------

-- ----------------------------
-- Table structure for infra_api_error_log
-- ----------------------------
DROP TABLE IF EXISTS `infra_api_error_log`;
CREATE TABLE `infra_api_error_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `trace_id` varchar(64) NOT NULL COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `application_name` varchar(50) NOT NULL COMMENT '应用名',
  `request_method` varchar(16) NOT NULL COMMENT '请求方法名',
  `request_url` varchar(255) NOT NULL COMMENT '请求地址',
  `request_params` varchar(8000) NOT NULL COMMENT '请求参数',
  `user_ip` varchar(50) NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) NOT NULL COMMENT '浏览器 UA',
  `exception_time` datetime NOT NULL COMMENT '异常发生时间',
  `exception_name` varchar(128) NOT NULL DEFAULT '' COMMENT '异常名',
  `exception_message` text NOT NULL COMMENT '异常导致的消息',
  `exception_root_cause_message` text NOT NULL COMMENT '异常导致的根消息',
  `exception_stack_trace` text NOT NULL COMMENT '异常的栈轨迹',
  `exception_class_name` varchar(512) NOT NULL COMMENT '异常发生的类全名',
  `exception_file_name` varchar(512) NOT NULL COMMENT '异常发生的类文件',
  `exception_method_name` varchar(512) NOT NULL COMMENT '异常发生的方法名',
  `exception_line_number` int NOT NULL COMMENT '异常发生的方法所在行',
  `process_status` tinyint NOT NULL COMMENT '处理状态',
  `process_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `process_user_id` int NULL DEFAULT 0 COMMENT '处理用户编号',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22210 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统异常日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_api_error_log
-- ----------------------------

-- ----------------------------
-- Table structure for infra_codegen_column
-- ----------------------------
DROP TABLE IF EXISTS `infra_codegen_column`;
CREATE TABLE `infra_codegen_column`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NOT NULL COMMENT '表编号',
  `column_name` varchar(200) NOT NULL COMMENT '字段名',
  `data_type` varchar(100) NOT NULL COMMENT '字段类型',
  `column_comment` varchar(500) NOT NULL COMMENT '字段描述',
  `nullable` bit(1) NOT NULL COMMENT '是否允许为空',
  `primary_key` bit(1) NOT NULL COMMENT '是否主键',
  `ordinal_position` int NOT NULL COMMENT '排序',
  `java_type` varchar(32) NOT NULL COMMENT 'Java 属性类型',
  `java_field` varchar(64) NOT NULL COMMENT 'Java 属性名',
  `dict_type` varchar(200) NULL DEFAULT '' COMMENT '字典类型',
  `example` varchar(64) NULL DEFAULT NULL COMMENT '数据示例',
  `create_operation` bit(1) NOT NULL COMMENT '是否为 Create 创建操作的字段',
  `update_operation` bit(1) NOT NULL COMMENT '是否为 Update 更新操作的字段',
  `list_operation` bit(1) NOT NULL COMMENT '是否为 List 查询操作的字段',
  `list_operation_condition` varchar(32) NOT NULL DEFAULT '=' COMMENT 'List 查询操作的条件类型',
  `list_operation_result` bit(1) NOT NULL COMMENT '是否为 List 查询操作的返回字段',
  `html_type` varchar(32) NOT NULL COMMENT '显示类型',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2538 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '代码生成表字段定义' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_codegen_column
-- ----------------------------

-- ----------------------------
-- Table structure for infra_codegen_table
-- ----------------------------
DROP TABLE IF EXISTS `infra_codegen_table`;
CREATE TABLE `infra_codegen_table`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `data_source_config_id` bigint NOT NULL COMMENT '数据源配置的编号',
  `scene` tinyint NOT NULL DEFAULT 1 COMMENT '生成场景',
  `table_name` varchar(200) NOT NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) NOT NULL DEFAULT '' COMMENT '表描述',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  `module_name` varchar(30) NOT NULL COMMENT '模块名',
  `business_name` varchar(30) NOT NULL COMMENT '业务名',
  `class_name` varchar(100) NOT NULL DEFAULT '' COMMENT '类名称',
  `class_comment` varchar(50) NOT NULL COMMENT '类描述',
  `author` varchar(50) NOT NULL COMMENT '作者',
  `template_type` tinyint NOT NULL DEFAULT 1 COMMENT '模板类型',
  `front_type` tinyint NOT NULL COMMENT '前端类型',
  `parent_menu_id` bigint NULL DEFAULT NULL COMMENT '父菜单编号',
  `master_table_id` bigint NULL DEFAULT NULL COMMENT '主表的编号',
  `sub_join_column_id` bigint NULL DEFAULT NULL COMMENT '子表关联主表的字段编号',
  `sub_join_many` bit(1) NULL DEFAULT NULL COMMENT '主表与子表是否一对多',
  `tree_parent_column_id` bigint NULL DEFAULT NULL COMMENT '树表的父字段编号',
  `tree_name_column_id` bigint NULL DEFAULT NULL COMMENT '树表的名字字段编号',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 191 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '代码生成表定义' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_codegen_table
-- ----------------------------

-- ----------------------------
-- Table structure for infra_config
-- ----------------------------
DROP TABLE IF EXISTS `infra_config`;
CREATE TABLE `infra_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `category` varchar(50) NOT NULL COMMENT '参数分组',
  `type` tinyint NOT NULL COMMENT '参数类型',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) NOT NULL DEFAULT '' COMMENT '参数键名',
  `value` varchar(500) NOT NULL DEFAULT '' COMMENT '参数键值',
  `visible` bit(1) NOT NULL COMMENT '是否可见',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_config
-- ----------------------------
INSERT INTO `infra_config` VALUES (1, 'biz', 1, '用户管理-账号初始密码', 'system.user.init-password', '123456', b'0', '初始化密码 123456', 'admin', '2021-01-05 17:03:48', '1', '2024-07-20 17:22:47', b'0');
INSERT INTO `infra_config` VALUES (2, 'url', 2, 'MySQL 监控的地址', 'url.druid', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:33:38', b'0');
INSERT INTO `infra_config` VALUES (3, 'url', 2, 'SkyWalking 监控的地址', 'url.skywalking', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:57:03', b'0');
INSERT INTO `infra_config` VALUES (4, 'url', 2, 'Spring Boot Admin 监控的地址', 'url.spring-boot-admin', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:52:07', b'0');
INSERT INTO `infra_config` VALUES (5, 'url', 2, 'Swagger 接口文档的地址', 'url.swagger', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:59:00', b'0');
INSERT INTO `infra_config` VALUES (6, 'ui', 2, '腾讯地图 key', 'tencent.lbs.key', 'TVDBZ-TDILD-4ON4B-PFDZA-RNLKH-VVF6E', b'1', '腾讯地图 key', '1', '2023-06-03 19:16:27', '1', '2023-06-03 19:16:27', b'0');
INSERT INTO `infra_config` VALUES (7, '用户管理-账号初始密码', 2, '用户管理-注册开关', 'system.user.register-enabled', 'true', b'0', '', '1', '2025-04-26 17:23:41', '1', '2025-04-26 17:23:41', b'0');

-- ----------------------------
-- Table structure for infra_data_source_config
-- ----------------------------
DROP TABLE IF EXISTS `infra_data_source_config`;
CREATE TABLE `infra_data_source_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '参数名称',
  `url` varchar(1024) NOT NULL COMMENT '数据源连接',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '数据源配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_data_source_config
-- ----------------------------

-- ----------------------------
-- Table structure for infra_file
-- ----------------------------
DROP TABLE IF EXISTS `infra_file`;
CREATE TABLE `infra_file`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件编号',
  `config_id` bigint NULL DEFAULT NULL COMMENT '配置编号',
  `name` varchar(256) NULL DEFAULT NULL COMMENT '文件名',
  `path` varchar(512) NOT NULL COMMENT '文件路径',
  `url` varchar(1024) NOT NULL COMMENT '文件 URL',
  `type` varchar(128) NULL DEFAULT NULL COMMENT '文件类型',
  `size` int NOT NULL COMMENT '文件大小',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1902 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_file
-- ----------------------------

-- ----------------------------
-- Table structure for infra_file_config
-- ----------------------------
DROP TABLE IF EXISTS `infra_file_config`;
CREATE TABLE `infra_file_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) NOT NULL COMMENT '配置名',
  `storage` tinyint NOT NULL COMMENT '存储器',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `master` bit(1) NOT NULL COMMENT '是否为主配置',
  `config` varchar(4096) NOT NULL COMMENT '存储配置',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_file_config
-- ----------------------------
INSERT INTO `infra_file_config` VALUES (4, '数据库（示例）', 1, '我是数据库', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.db.DBFileClientConfig\",\"domain\":\"http://127.0.0.1:48080\"}', '1', '2022-03-15 23:56:24', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (22, '七牛存储器（示例）', 20, '请换成你自己的密钥！！！', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"s3.cn-south-1.qiniucs.com\",\"domain\":\"http://test.yudao.iocoder.cn\",\"bucket\":\"ruoyi-vue-pro\",\"accessKey\":\"3TvrJ70gl2Gt6IBe7_IZT1F6i_k0iMuRtyEv4EyS\",\"accessSecret\":\"wd0tbVBYlp0S-ihA8Qg2hPLncoP83wyrIq24OZuY\",\"enablePathStyleAccess\":false}', '1', '2024-01-13 22:11:12', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (24, '腾讯云存储（示例）', 20, '请换成你的密钥！！！', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"https://cos.ap-shanghai.myqcloud.com\",\"domain\":\"http://tengxun-oss.iocoder.cn\",\"bucket\":\"aoteman-1255880240\",\"accessKey\":\"AKIDAF6WSh1uiIjwqtrOsGSN3WryqTM6cTMt\",\"accessSecret\":\"X\"}', '1', '2024-11-09 16:03:22', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (25, '阿里云存储（示例）', 20, '', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"oss-cn-beijing.aliyuncs.com\",\"domain\":\"http://ali-oss.iocoder.cn\",\"bucket\":\"yunai-aoteman\",\"accessKey\":\"LTAI5tEQLgnDyjh3WpNcdMKA\",\"accessSecret\":\"X\",\"enablePathStyleAccess\":false}', '1', '2024-11-09 16:47:08', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (26, '火山云存储（示例）', 20, '', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"tos-s3-cn-beijing.volces.com\",\"domain\":null,\"bucket\":\"yunai\",\"accessKey\":\"AKLTZjc3Zjc4MzZmMjU3NDk0ZTgxYmIyMmFkNTIwMDI1ZGE\",\"accessSecret\":\"X==\",\"enablePathStyleAccess\":false}', '1', '2024-11-09 16:56:42', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (27, '华为云存储（示例）', 20, '', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"obs.cn-east-3.myhuaweicloud.com\",\"domain\":\"\",\"bucket\":\"yudao\",\"accessKey\":\"PVDONDEIOTW88LF8DC4U\",\"accessSecret\":\"X\",\"enablePathStyleAccess\":false}', '1', '2024-11-09 17:18:41', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (28, 'MinIO 存储（示例）', 20, '', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"http://127.0.0.1:9000\",\"domain\":\"http://127.0.0.1:9000/yudao\",\"bucket\":\"yudao\",\"accessKey\":\"admin\",\"accessSecret\":\"password\",\"enablePathStyleAccess\":false}', '1', '2024-11-09 17:43:10', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (29, '本地存储（示例）', 10, '仅适合 mac 或 windows', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.local.LocalFileClientConfig\",\"basePath\":\"/Users/yunai/tmp/file\",\"domain\":\"http://127.0.0.1:48080\"}', '1', '2025-05-02 11:25:45', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (30, 'SFTP 存储（示例）', 12, '', b'0', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.sftp.SftpFileClientConfig\",\"basePath\":\"/upload\",\"domain\":\"http://127.0.0.1:48080\",\"host\":\"127.0.0.1\",\"port\":2222,\"username\":\"foo\",\"password\":\"pass\"}', '1', '2025-05-02 16:34:10', '1', '2025-06-21 15:14:30', b'0');
INSERT INTO `infra_file_config` VALUES (31, 'MinIO存储', 20, 'http://192.168.56.128:9000', b'1', '{\"@class\":\"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig\",\"endpoint\":\"http://192.168.56.128:9000\",\"domain\":null,\"bucket\":\"mall\",\"accessKey\":\"admin\",\"accessSecret\":\"1234567890\",\"enablePathStyleAccess\":false}', '1', '2025-06-21 15:14:18', '1', '2025-06-21 15:15:39', b'0');

-- ----------------------------
-- Table structure for infra_file_content
-- ----------------------------
DROP TABLE IF EXISTS `infra_file_content`;
CREATE TABLE `infra_file_content`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `config_id` bigint NOT NULL COMMENT '配置编号',
  `path` varchar(512) NOT NULL COMMENT '文件路径',
  `content` mediumblob NOT NULL COMMENT '文件内容',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 286 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_file_content
-- ----------------------------

-- ----------------------------
-- Table structure for infra_job
-- ----------------------------
DROP TABLE IF EXISTS `infra_job`;
CREATE TABLE `infra_job`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务编号',
  `name` varchar(32) NOT NULL COMMENT '任务名称',
  `status` tinyint NOT NULL COMMENT '任务状态',
  `handler_name` varchar(64) NOT NULL COMMENT '处理器的名字',
  `handler_param` varchar(255) NULL DEFAULT NULL COMMENT '处理器的参数',
  `cron_expression` varchar(32) NOT NULL COMMENT 'CRON 表达式',
  `retry_count` int NOT NULL DEFAULT 0 COMMENT '重试次数',
  `retry_interval` int NOT NULL DEFAULT 0 COMMENT '重试间隔',
  `monitor_timeout` int NOT NULL DEFAULT 0 COMMENT '监控超时时间',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '定时任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_job
-- ----------------------------
INSERT INTO `infra_job` VALUES (1, '支付通知 Job', 2, 'payNotifyJob', NULL, '* * * * * ?', 0, 0, 0, '1', '2021-10-27 08:34:42', '1', '2024-09-12 13:32:48', b'0');
INSERT INTO `infra_job` VALUES (2, '支付订单同步 Job', 2, 'payOrderSyncJob', NULL, '0 0/1 * * * ?', 0, 0, 0, '1', '2023-07-22 14:36:26', '1', '2023-07-22 15:39:08', b'0');
INSERT INTO `infra_job` VALUES (3, '支付订单过期 Job', 2, 'payOrderExpireJob', NULL, '0 0/1 * * * ?', 0, 0, 0, '1', '2023-07-22 15:36:23', '1', '2023-07-22 15:39:54', b'0');
INSERT INTO `infra_job` VALUES (4, '退款订单的同步 Job', 2, 'payRefundSyncJob', NULL, '0 0/1 * * * ?', 0, 0, 0, '1', '2023-07-23 21:03:44', '1', '2023-07-23 21:09:00', b'0');
INSERT INTO `infra_job` VALUES (5, '交易订单的自动过期 Job', 2, 'tradeOrderAutoCancelJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-25 23:43:26', '1', '2023-09-26 19:23:30', b'0');
INSERT INTO `infra_job` VALUES (6, '交易订单的自动收货 Job', 2, 'tradeOrderAutoReceiveJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-26 19:23:53', '1', '2023-09-26 23:38:08', b'0');
INSERT INTO `infra_job` VALUES (7, '交易订单的自动评论 Job', 2, 'tradeOrderAutoCommentJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-26 23:38:29', '1', '2023-09-27 11:03:10', b'0');
INSERT INTO `infra_job` VALUES (8, '佣金解冻 Job', 2, 'brokerageRecordUnfreezeJob', '', '0 * * * * ?', 3, 0, 0, '1', '2023-09-28 22:01:46', '1', '2023-09-28 22:01:56', b'0');
INSERT INTO `infra_job` VALUES (9, '访问日志清理 Job', 2, 'accessLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 10:59:41', '1', '2023-10-03 11:01:10', b'0');
INSERT INTO `infra_job` VALUES (10, '错误日志清理 Job', 2, 'errorLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 11:00:43', '1', '2023-10-03 11:01:12', b'0');
INSERT INTO `infra_job` VALUES (11, '任务日志清理 Job', 2, 'jobLogCleanJob', '', '0 0 0 * * ?', 3, 0, 0, '1', '2023-10-03 11:01:33', '1', '2024-09-12 13:40:34', b'0');
INSERT INTO `infra_job` VALUES (12, '转账订单的同步 Job', 2, 'payTransferSyncJob', '', '0 * * * * ?', 0, 0, 0, '1', '2025-05-10 17:35:54', '1', '2025-05-10 18:13:52', b'0');

-- ----------------------------
-- Table structure for infra_job_log
-- ----------------------------
DROP TABLE IF EXISTS `infra_job_log`;
CREATE TABLE `infra_job_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `job_id` bigint NOT NULL COMMENT '任务编号',
  `handler_name` varchar(64) NOT NULL COMMENT '处理器的名字',
  `handler_param` varchar(255) NULL DEFAULT NULL COMMENT '处理器的参数',
  `execute_index` tinyint NOT NULL DEFAULT 1 COMMENT '第几次执行',
  `begin_time` datetime NOT NULL COMMENT '开始执行时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束执行时间',
  `duration` int NULL DEFAULT NULL COMMENT '执行时长',
  `status` tinyint NOT NULL COMMENT '任务状态',
  `result` varchar(4000) NULL DEFAULT '' COMMENT '结果数据',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 972 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '定时任务日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infra_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for member_address
-- ----------------------------
DROP TABLE IF EXISTS `member_address`;
CREATE TABLE `member_address`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `name` varchar(255) NOT NULL COMMENT '收件人名称',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `area_id` bigint NOT NULL COMMENT '地区编号',
  `detail_address` varchar(1000) NOT NULL COMMENT '收件详细地址',
  `default_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认 (1: 是, 0: 否)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 (1: 已删除, 0: 未删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户收件地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_address
-- ----------------------------

-- ----------------------------
-- Table structure for member_config
-- ----------------------------
DROP TABLE IF EXISTS `member_config`;
CREATE TABLE `member_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `point_trade_deduct_enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '积分抵扣开关 (1: 开启, 0: 关闭)',
  `point_trade_deduct_unit_price` int NOT NULL DEFAULT 0 COMMENT '积分抵扣单位价格（单位：分）',
  `point_trade_deduct_max_price` int NOT NULL DEFAULT 0 COMMENT '积分抵扣最大值',
  `point_trade_give_point` int NOT NULL DEFAULT 0 COMMENT '1元赠送多少分',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 (1: 已删除, 0: 未删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_config
-- ----------------------------

-- ----------------------------
-- Table structure for member_experience_record
-- ----------------------------
DROP TABLE IF EXISTS `member_experience_record`;
CREATE TABLE `member_experience_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `biz_type` int NOT NULL COMMENT '业务类型 (1: 注册, 2: 签到, 3: 购买商品等)',
  `biz_id` varchar(255) NOT NULL COMMENT '业务编号',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `description` varchar(1000) NULL DEFAULT NULL COMMENT '描述',
  `experience` int NOT NULL COMMENT '经验变化值',
  `total_experience` int NOT NULL COMMENT '变更后的总经验',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 (1: 已删除, 0: 未删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员经验记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_experience_record
-- ----------------------------

-- ----------------------------
-- Table structure for member_group
-- ----------------------------
DROP TABLE IF EXISTS `member_group`;
CREATE TABLE `member_group`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `remark` varchar(1000) NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态 (1: 启用, 0: 禁用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 (1: 已删除, 0: 未删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_group
-- ----------------------------

-- ----------------------------
-- Table structure for member_level
-- ----------------------------
DROP TABLE IF EXISTS `member_level`;
CREATE TABLE `member_level`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) NOT NULL COMMENT '等级名称',
  `level` int NOT NULL COMMENT '等级值（从1开始递增）',
  `experience` int NOT NULL COMMENT '升级所需经验',
  `discount_percent` int NOT NULL COMMENT '享受折扣百分比（例如 95 表示 9.5 折）',
  `icon` varchar(512) NULL DEFAULT NULL COMMENT '等级图标 URL',
  `background_url` varchar(512) NULL DEFAULT NULL COMMENT '等级背景图 URL',
  `status` int NOT NULL COMMENT '状态 (1: 启用, 0: 禁用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 (1: 已删除, 0: 未删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员等级配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_level
-- ----------------------------

-- ----------------------------
-- Table structure for member_level_record
-- ----------------------------
DROP TABLE IF EXISTS `member_level_record`;
CREATE TABLE `member_level_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `level_id` bigint NOT NULL COMMENT '等级编号',
  `level` int NOT NULL COMMENT '会员等级值',
  `discount_percent` int NOT NULL COMMENT '享受折扣百分比（例如 95 表示 9.5 折）',
  `experience` int NOT NULL COMMENT '升级所需经验',
  `user_experience` int NOT NULL COMMENT '用户当前经验值',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `description` varchar(1000) NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 (1: 已删除, 0: 未删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员等级记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_level_record
-- ----------------------------

-- ----------------------------
-- Table structure for member_point_record
-- ----------------------------
DROP TABLE IF EXISTS `member_point_record`;
CREATE TABLE `member_point_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `biz_id` varchar(255) NOT NULL COMMENT '业务编号',
  `biz_type` int NOT NULL COMMENT '业务类型 (1: 注册, 2: 签到, 3: 购买商品等)',
  `title` varchar(255) NOT NULL COMMENT '积分标题',
  `description` varchar(1000) NULL DEFAULT NULL COMMENT '积分描述',
  `point` int NOT NULL COMMENT '变动积分（正数为获得，负数为消耗）',
  `total_point` int NOT NULL COMMENT '变动后的总积分',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除 (1: 已删除, 0: 未删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户积分记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_point_record
-- ----------------------------

-- ----------------------------
-- Table structure for member_sign_in_config
-- ----------------------------
DROP TABLE IF EXISTS `member_sign_in_config`;
CREATE TABLE `member_sign_in_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则自增主键',
  `day` int NOT NULL COMMENT '签到第 x 天',
  `point` int NOT NULL COMMENT '奖励积分',
  `experience` int NOT NULL COMMENT '奖励经验',
  `status` int NOT NULL COMMENT '状态 (枚举 CommonStatusEnum)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '签到规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_sign_in_config
-- ----------------------------

-- ----------------------------
-- Table structure for member_sign_in_record
-- ----------------------------
DROP TABLE IF EXISTS `member_sign_in_record`;
CREATE TABLE `member_sign_in_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号（主键）',
  `user_id` bigint NOT NULL COMMENT '签到用户',
  `day` int NOT NULL COMMENT '第几天签到',
  `point` int NOT NULL COMMENT '签到的积分',
  `experience` int NOT NULL COMMENT '签到的经验',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '签到记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_sign_in_record
-- ----------------------------

-- ----------------------------
-- Table structure for member_tag
-- ----------------------------
DROP TABLE IF EXISTS `member_tag`;
CREATE TABLE `member_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号（主键）',
  `name` varchar(255) NOT NULL COMMENT '标签名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_tag
-- ----------------------------

-- ----------------------------
-- Table structure for member_user
-- ----------------------------
DROP TABLE IF EXISTS `member_user`;
CREATE TABLE `member_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID（主键）',
  `mobile` varchar(45) NOT NULL COMMENT '手机号码',
  `password` varchar(100) NOT NULL COMMENT '加密后的密码',
  `status` int NOT NULL COMMENT '账号状态 (枚举 CommonStatusEnum)',
  `register_ip` varchar(45) NOT NULL COMMENT '注册IP',
  `register_terminal` int NOT NULL COMMENT '注册终端 (枚举 TerminalEnum)',
  `login_ip` varchar(45) NULL DEFAULT NULL COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `nickname` varchar(45) NOT NULL COMMENT '用户昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像URL',
  `name` varchar(45) NULL DEFAULT NULL COMMENT '真实姓名',
  `sex` int NULL DEFAULT NULL COMMENT '性别 (枚举 SexEnum)',
  `birthday` datetime NULL DEFAULT NULL COMMENT '出生日期',
  `area_id` int NULL DEFAULT NULL COMMENT '所在地区域ID (关联 Area 表)',
  `mark` varchar(255) NULL DEFAULT NULL COMMENT '用户备注',
  `point` int NOT NULL DEFAULT 0 COMMENT '当前积分',
  `tag_ids` text NULL COMMENT '会员标签列表 (逗号分隔的Long类型ID)',
  `level_id` bigint NULL DEFAULT NULL COMMENT '会员级别ID (关联 member_level.id)',
  `experience` int NOT NULL DEFAULT 0 COMMENT '当前经验',
  `group_id` bigint NULL DEFAULT NULL COMMENT '用户分组ID (关联 member_group.id)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_mobile`(`mobile` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_user
-- ----------------------------

-- ----------------------------
-- Table structure for pay_app
-- ----------------------------
DROP TABLE IF EXISTS `pay_app`;
CREATE TABLE `pay_app`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '应用编号',
  `app_key` varchar(255) NOT NULL COMMENT '应用标识',
  `name` varchar(255) NOT NULL COMMENT '应用名',
  `status` int NOT NULL COMMENT '状态（0=开启 1=关闭）',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `order_notify_url` varchar(255) NULL DEFAULT NULL COMMENT '支付回调地址',
  `refund_notify_url` varchar(255) NULL DEFAULT NULL COMMENT '退款回调地址',
  `transfer_notify_url` varchar(255) NULL DEFAULT NULL COMMENT '转账回调地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0=未删除 1=已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付应用表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_app
-- ----------------------------

-- ----------------------------
-- Table structure for pay_channel
-- ----------------------------
DROP TABLE IF EXISTS `pay_channel`;
CREATE TABLE `pay_channel`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '渠道编号',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  `code` varchar(255) NOT NULL COMMENT '渠道编码',
  `status` int NOT NULL COMMENT '状态',
  `fee_rate` double NOT NULL COMMENT '渠道费率(百分比)',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `app_id` bigint NOT NULL COMMENT '应用编号',
  `config`  varchar(10240) NULL COMMENT '支付渠道配置',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付渠道表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_channel
-- ----------------------------

-- ----------------------------
-- Table structure for pay_demo_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_demo_order`;
CREATE TABLE `pay_demo_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `spu_id` bigint NOT NULL COMMENT '商品编号',
  `spu_name` varchar(255) NOT NULL COMMENT '商品名称',
  `price` int NOT NULL COMMENT '价格(分)',
  `pay_status` tinyint(1) NULL DEFAULT NULL COMMENT '是否支付',
  `pay_order_id` bigint NULL DEFAULT NULL COMMENT '支付订单编号',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `pay_channel_code` varchar(255) NULL DEFAULT NULL COMMENT '支付渠道',
  `pay_refund_id` bigint NULL DEFAULT NULL COMMENT '支付退款单号',
  `refund_price` int NULL DEFAULT NULL COMMENT '退款金额(分)',
  `refund_time` datetime NULL DEFAULT NULL COMMENT '退款时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '示例订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_demo_order
-- ----------------------------

-- ----------------------------
-- Table structure for pay_demo_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `pay_demo_withdraw`;
CREATE TABLE `pay_demo_withdraw`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '提现单编号',
  `subject` varchar(255) NOT NULL COMMENT '提现标题',
  `price` int NOT NULL COMMENT '提现金额(分)',
  `user_account` varchar(255) NOT NULL COMMENT '收款账号',
  `user_name` varchar(255) NOT NULL COMMENT '收款姓名',
  `type` int NOT NULL COMMENT '提现方式',
  `status` int NOT NULL COMMENT '提现状态',
  `pay_transfer_id` bigint NULL DEFAULT NULL COMMENT '转账单编号',
  `transfer_channel_code` varchar(255) NULL DEFAULT NULL COMMENT '转账渠道',
  `transfer_time` datetime NULL DEFAULT NULL COMMENT '转账时间',
  `transfer_error_msg` varchar(255) NULL DEFAULT NULL COMMENT '转账错误提示',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '示例提现表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_demo_withdraw
-- ----------------------------

-- ----------------------------
-- Table structure for pay_notify_log
-- ----------------------------
DROP TABLE IF EXISTS `pay_notify_log`;
CREATE TABLE `pay_notify_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `task_id` bigint NOT NULL COMMENT '通知任务编号',
  `notify_times` int NOT NULL COMMENT '通知次数',
  `response` text NULL COMMENT 'HTTP响应结果',
  `status` int NOT NULL COMMENT '通知状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付通知日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_notify_log
-- ----------------------------

-- ----------------------------
-- Table structure for pay_notify_task
-- ----------------------------
DROP TABLE IF EXISTS `pay_notify_task`;
CREATE TABLE `pay_notify_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务编号',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  `app_id` bigint NOT NULL COMMENT '应用编号',
  `type` int NOT NULL COMMENT '通知类型',
  `data_id` bigint NOT NULL COMMENT '数据编号',
  `merchant_order_id` varchar(255) NULL DEFAULT NULL COMMENT '商户订单号',
  `merchant_refund_id` varchar(255) NULL DEFAULT NULL COMMENT '商户退款号',
  `merchant_transfer_id` varchar(255) NULL DEFAULT NULL COMMENT '商户转账号',
  `status` int NOT NULL COMMENT '通知状态',
  `next_notify_time` datetime NOT NULL COMMENT '下次通知时间',
  `last_execute_time` datetime NULL DEFAULT NULL COMMENT '最后执行时间',
  `notify_times` int NOT NULL COMMENT '当前通知次数',
  `max_notify_times` int NOT NULL COMMENT '最大通知次数',
  `notify_url` varchar(255) NOT NULL COMMENT '通知地址',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付通知任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_notify_task
-- ----------------------------

-- ----------------------------
-- Table structure for pay_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_order`;
CREATE TABLE `pay_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `app_id` bigint NOT NULL COMMENT '应用编号',
  `channel_id` bigint NOT NULL COMMENT '渠道编号',
  `channel_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道编码',
  `merchant_order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户订单编号',
  `subject` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品标题',
  `body` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品描述',
  `notify_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '异步通知地址',
  `price` int NOT NULL COMMENT '支付金额(分)',
  `channel_fee_rate` double NULL DEFAULT NULL COMMENT '渠道手续费百分比',
  `channel_fee_price` int NULL DEFAULT NULL COMMENT '渠道手续金额(分)',
  `status` int NOT NULL COMMENT '支付状态',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户IP',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '订单失效时间',
  `success_time` datetime NULL DEFAULT NULL COMMENT '支付成功时间',
  `extension_id` bigint NULL DEFAULT NULL COMMENT '支付拓展单编号',
  `no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付成功外部订单号',
  `refund_price` int NULL DEFAULT 0 COMMENT '退款总金额(分)',
  `channel_user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道用户编号',
  `channel_order_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道订单号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_app_id`(`app_id` ASC) USING BTREE,
  INDEX `idx_merchant_order_id`(`merchant_order_id` ASC) USING BTREE,
  INDEX `idx_channel_order_no`(`channel_order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_order
-- ----------------------------

-- ----------------------------
-- Table structure for pay_order_extension
-- ----------------------------
DROP TABLE IF EXISTS `pay_order_extension`;
CREATE TABLE `pay_order_extension`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单拓展编号',
  `no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '外部订单号',
  `order_id` bigint NOT NULL COMMENT '订单编号',
  `channel_id` bigint NOT NULL COMMENT '渠道编号',
  `channel_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道编码',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户IP',
  `status` int NOT NULL COMMENT '支付状态',
  `channel_extras` varchar(1024) NULL COMMENT '渠道额外参数',
  `channel_error_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误码',
  `channel_error_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误信息',
  `channel_notify_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '渠道通知内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_no`(`no` ASC) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付订单拓展表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_order_extension
-- ----------------------------

-- ----------------------------
-- Table structure for pay_refund
-- ----------------------------
DROP TABLE IF EXISTS `pay_refund`;
CREATE TABLE `pay_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '退款单编号',
  `no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '外部退款号',
  `app_id` bigint NOT NULL COMMENT '应用编号',
  `channel_id` bigint NOT NULL COMMENT '渠道编号',
  `channel_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道编码',
  `order_id` bigint NOT NULL COMMENT '订单编号',
  `order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付订单号',
  `merchant_order_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户订单编号',
  `merchant_refund_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户退款单号',
  `notify_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '异步通知地址',
  `status` int NOT NULL COMMENT '退款状态',
  `pay_price` int NOT NULL COMMENT '支付金额(分)',
  `refund_price` int NOT NULL COMMENT '退款金额(分)',
  `reason` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '退款原因',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户IP',
  `channel_order_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道订单号',
  `channel_refund_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道退款单号',
  `success_time` datetime NULL DEFAULT NULL COMMENT '退款成功时间',
  `channel_error_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误码',
  `channel_error_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误信息',
  `channel_notify_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '渠道通知内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_no`(`no` ASC) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_merchant_refund_id`(`merchant_refund_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付退款表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_refund
-- ----------------------------

-- ----------------------------
-- Table structure for pay_transfer
-- ----------------------------
DROP TABLE IF EXISTS `pay_transfer`;
CREATE TABLE `pay_transfer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '转账单编号',
  `no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '转账单号',
  `app_id` bigint NOT NULL COMMENT '应用编号',
  `channel_id` bigint NOT NULL COMMENT '渠道编号',
  `channel_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道编码',
  `merchant_transfer_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户转账单号',
  `subject` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '转账标题',
  `price` int NOT NULL COMMENT '转账金额(分)',
  `user_account` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收款账号',
  `user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收款姓名',
  `status` int NOT NULL COMMENT '转账状态',
  `success_time` datetime NULL DEFAULT NULL COMMENT '成功时间',
  `notify_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知地址',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户IP',
  `channel_extras` varchar(1024) NULL COMMENT '渠道额外参数',
  `channel_transfer_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道转账单号',
  `channel_error_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误码',
  `channel_error_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '渠道错误信息',
  `channel_notify_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '渠道通知内容',
  `channel_package_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '渠道package信息',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_no`(`no` ASC) USING BTREE,
  INDEX `idx_merchant_transfer_id`(`merchant_transfer_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '转账表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_transfer
-- ----------------------------

-- ----------------------------
-- Table structure for pay_wallet
-- ----------------------------
DROP TABLE IF EXISTS `pay_wallet`;
CREATE TABLE `pay_wallet`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '钱包编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `user_type` int NOT NULL COMMENT '用户类型',
  `balance` int NOT NULL DEFAULT 0 COMMENT '余额(分)',
  `freeze_price` int NOT NULL DEFAULT 0 COMMENT '冻结金额(分)',
  `total_expense` int NOT NULL DEFAULT 0 COMMENT '累计支出(分)',
  `total_recharge` int NOT NULL DEFAULT 0 COMMENT '累计充值(分)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_user`(`user_id` ASC, `user_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员钱包表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_wallet
-- ----------------------------

-- ----------------------------
-- Table structure for pay_wallet_recharge
-- ----------------------------
DROP TABLE IF EXISTS `pay_wallet_recharge`;
CREATE TABLE `pay_wallet_recharge`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '充值编号',
  `wallet_id` bigint NOT NULL COMMENT '钱包编号',
  `total_price` int NOT NULL COMMENT '到账金额(分)',
  `pay_price` int NOT NULL COMMENT '实付金额(分)',
  `bonus_price` int NOT NULL COMMENT '赠送金额(分)',
  `package_id` bigint NULL DEFAULT NULL COMMENT '套餐编号',
  `pay_status` tinyint(1) NOT NULL COMMENT '是否支付',
  `pay_order_id` bigint NULL DEFAULT NULL COMMENT '支付订单号',
  `pay_channel_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付渠道',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `pay_refund_id` bigint NULL DEFAULT NULL COMMENT '退款单号',
  `refund_total_price` int NULL DEFAULT NULL COMMENT '退款总金额',
  `refund_pay_price` int NULL DEFAULT NULL COMMENT '退款实付金额',
  `refund_bonus_price` int NULL DEFAULT NULL COMMENT '退款赠送金额',
  `refund_time` datetime NULL DEFAULT NULL COMMENT '退款时间',
  `refund_status` int NULL DEFAULT NULL COMMENT '退款状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_wallet_id`(`wallet_id` ASC) USING BTREE,
  INDEX `idx_pay_order_id`(`pay_order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包充值表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_wallet_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for pay_wallet_recharge_package
-- ----------------------------
DROP TABLE IF EXISTS `pay_wallet_recharge_package`;
CREATE TABLE `pay_wallet_recharge_package`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐名称',
  `pay_price` int NOT NULL COMMENT '支付金额(分)',
  `bonus_price` int NOT NULL COMMENT '赠送金额(分)',
  `status` int NOT NULL COMMENT '状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包充值套餐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_wallet_recharge_package
-- ----------------------------

-- ----------------------------
-- Table structure for pay_wallet_transaction
-- ----------------------------
DROP TABLE IF EXISTS `pay_wallet_transaction`;
CREATE TABLE `pay_wallet_transaction`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '流水编号',
  `no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流水号',
  `wallet_id` bigint NOT NULL COMMENT '钱包编号',
  `biz_type` int NOT NULL COMMENT '业务类型',
  `biz_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务编号',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流水说明',
  `price` int NOT NULL COMMENT '交易金额(分)',
  `balance` int NOT NULL COMMENT '交易后余额(分)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_wallet_id`(`wallet_id` ASC) USING BTREE,
  INDEX `idx_biz`(`biz_type` ASC, `biz_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钱包流水表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_wallet_transaction
-- ----------------------------

-- ----------------------------
-- Table structure for product_brand
-- ----------------------------
DROP TABLE IF EXISTS `product_brand`;
CREATE TABLE `product_brand`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '品牌编号',
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `pic_url` varchar(255) NOT NULL COMMENT '品牌图片',
  `sort` int NOT NULL COMMENT '品牌排序',
  `description` text NOT NULL COMMENT '品牌描述',
  `status` int NOT NULL COMMENT '状态 (枚举 CommonStatusEnum)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除 (0:未删除, 1:已删除)',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品品牌表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_brand
-- ----------------------------

-- ----------------------------
-- Table structure for product_browse_history
-- ----------------------------
DROP TABLE IF EXISTS `product_browse_history`;
CREATE TABLE `product_browse_history`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录编号，主键自增',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_deleted` tinyint(1) NOT NULL COMMENT '用户是否删除（0：未删除，1：已删除）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_spu`(`user_id` ASC, `spu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品浏览记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_browse_history
-- ----------------------------

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类编号',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父分类编号，0表示根分类',
  `name` varchar(255) NOT NULL COMMENT '分类名称',
  `pic_url` varchar(1024) NULL DEFAULT NULL COMMENT '移动端分类图（建议180*180分辨率）',
  `sort` int NOT NULL COMMENT '分类排序',
  `status` int NOT NULL COMMENT '开启状态（枚举 CommonStatusEnum）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_category
-- ----------------------------

-- ----------------------------
-- Table structure for product_comment
-- ----------------------------
DROP TABLE IF EXISTS `product_comment`;
CREATE TABLE `product_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '评价人的用户编号（关联 MemberUserDO 的 id 编号）',
  `user_nickname` varchar(255) NOT NULL COMMENT '评价人名称',
  `user_avatar` varchar(1024) NULL DEFAULT NULL COMMENT '评价人头像',
  `anonymous` tinyint(1) NOT NULL COMMENT '是否匿名（0：不匿名，1：匿名）',
  `order_id` bigint NOT NULL COMMENT '交易订单编号（关联 TradeOrderDO 的 id 编号）',
  `order_item_id` bigint NOT NULL COMMENT '交易订单项编号（关联 TradeOrderItemDO 的 id 编号）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号（关联 ProductSpuDO 的 id 编号）',
  `spu_name` varchar(255) NOT NULL COMMENT '商品 SPU 名称（关联 ProductSpuDO 的 name 字段）',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号（关联 ProductSkuDO 的 id 编号）',
  `sku_pic_url` varchar(1024) NULL DEFAULT NULL COMMENT '商品 SKU 图片地址（关联 ProductSkuDO 的 picUrl 字段）',
  `sku_properties` varchar(8192) NOT NULL COMMENT '属性数组，JSON 格式（关联 ProductSkuDO 的 properties 字段）',
  `visible` tinyint(1) NOT NULL COMMENT '是否可见（0：隐藏，1：显示）',
  `scores` int NOT NULL COMMENT '评分星级（1-5 分）',
  `description_scores` int NOT NULL COMMENT '描述星级（1-5 星）',
  `benefit_scores` int NOT NULL COMMENT '服务星级（1-5 星）',
  `content` text NOT NULL COMMENT '评论内容',
  `pic_urls` varchar(4096) NOT NULL COMMENT '评论图片地址数组，JSON 格式',
  `reply_status` tinyint(1) NOT NULL COMMENT '商家是否回复（0：未回复，1：已回复）',
  `reply_user_id` bigint NULL DEFAULT NULL COMMENT '回复管理员编号（关联 AdminUserDO 的 id 编号）',
  `reply_content` text NULL COMMENT '商家回复内容',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '商家回复时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_comment
-- ----------------------------

-- ----------------------------
-- Table structure for product_favorite
-- ----------------------------
DROP TABLE IF EXISTS `product_favorite`;
CREATE TABLE `product_favorite`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '用户编号（关联 MemberUserDO 的 id 编号）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号（关联 ProductSpuDO 的 id 编号）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_spu`(`user_id` ASC, `spu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for product_property
-- ----------------------------
DROP TABLE IF EXISTS `product_property`;
CREATE TABLE `product_property`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '属性项编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '属性名称',
  `remark` varchar(1024) NULL DEFAULT NULL COMMENT '备注信息',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品属性项表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_property
-- ----------------------------

-- ----------------------------
-- Table structure for product_property_value
-- ----------------------------
DROP TABLE IF EXISTS `product_property_value`;
CREATE TABLE `product_property_value`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '属性值编号，主键自增',
  `property_id` bigint NOT NULL COMMENT '属性项编号（关联 product_property.id）',
  `name` varchar(255) NOT NULL COMMENT '属性值名称',
  `remark` varchar(1024) NULL DEFAULT NULL COMMENT '备注信息',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_property_name`(`property_id` ASC, `name` ASC) USING BTREE,
  INDEX `idx_property_id`(`property_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品属性值表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_property_value
-- ----------------------------

-- ----------------------------
-- Table structure for product_sku
-- ----------------------------
DROP TABLE IF EXISTS `product_sku`;
CREATE TABLE `product_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品 SKU 编号，主键自增',
  `spu_id` bigint NOT NULL COMMENT 'SPU 编号（关联 product_spu.id）',
  `properties` varchar(5120) NOT NULL COMMENT '属性数组，JSON 格式（包含 property_id、property_name、value_id、value_name）',
  `price` int NOT NULL COMMENT '商品价格，单位：分',
  `market_price` int NOT NULL COMMENT '市场价，单位：分',
  `cost_price` int NOT NULL COMMENT '成本价，单位：分',
  `bar_code` varchar(255) NULL DEFAULT NULL COMMENT '商品条码',
  `pic_url` varchar(1024) NULL DEFAULT NULL COMMENT '图片地址',
  `stock` int NOT NULL COMMENT '库存',
  `weight` double NULL DEFAULT NULL COMMENT '商品重量，单位：kg 千克',
  `volume` double NULL DEFAULT NULL COMMENT '商品体积，单位：m^3 平米',
  `first_brokerage_price` int NULL DEFAULT NULL COMMENT '一级分销佣金，单位：分',
  `second_brokerage_price` int NULL DEFAULT NULL COMMENT '二级分销佣金，单位：分',
  `sales_count` int NOT NULL DEFAULT 0 COMMENT '商品销量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品 SKU 表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_sku
-- ----------------------------

-- ----------------------------
-- Table structure for product_spu
-- ----------------------------
DROP TABLE IF EXISTS `product_spu`;
CREATE TABLE `product_spu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品 SPU 编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '商品名称',
  `keyword` varchar(255) NULL DEFAULT NULL COMMENT '关键字',
  `introduction` varchar(512) NULL DEFAULT NULL COMMENT '商品简介',
  `description` text NULL COMMENT '商品详情',
  `category_id` bigint NOT NULL COMMENT '商品分类编号（关联 product_category.id）',
  `brand_id` bigint NULL DEFAULT NULL COMMENT '商品品牌编号（关联 product_brand.id）',
  `pic_url` varchar(1024) NULL DEFAULT NULL COMMENT '商品封面图',
  `slider_pic_urls` varchar(2048) NULL COMMENT '商品轮播图数组（JSON 格式）',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序字段',
  `status` int NOT NULL COMMENT '商品状态（枚举 ProductSpuStatusEnum）',
  `spec_type` tinyint(1) NOT NULL COMMENT '规格类型（0：单规格，1：多规格）',
  `price` int NOT NULL COMMENT '商品价格，单位：分',
  `market_price` int NOT NULL COMMENT '市场价，单位：分',
  `cost_price` int NOT NULL COMMENT '成本价，单位：分',
  `stock` int NOT NULL COMMENT '库存',
  `delivery_types` varchar(2048) NULL DEFAULT NULL COMMENT '配送方式数组（枚举 DeliveryTypeEnum）',
  `delivery_template_id` bigint NULL DEFAULT NULL COMMENT '物流配置模板编号（关联 trade_delivery_express_template.id）',
  `give_integral` int NULL DEFAULT NULL COMMENT '赠送积分',
  `sub_commission_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '分销类型（0：默认，1：自行设置）',
  `sales_count` int NOT NULL DEFAULT 0 COMMENT '商品销量',
  `virtual_sales_count` int NOT NULL DEFAULT 0 COMMENT '虚拟销量',
  `browse_count` int NOT NULL DEFAULT 0 COMMENT '浏览量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_brand_id`(`brand_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品 SPU 表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_spu
-- ----------------------------

-- ----------------------------
-- Table structure for product_statistics
-- ----------------------------
DROP TABLE IF EXISTS `product_statistics`;
CREATE TABLE `product_statistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号，主键自增',
  `time` date NOT NULL COMMENT '统计日期',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `browse_count` int NOT NULL COMMENT '浏览量',
  `browse_user_count` int NOT NULL COMMENT '访客量',
  `favorite_count` int NOT NULL COMMENT '收藏数量',
  `cart_count` int NOT NULL COMMENT '加购数量',
  `order_count` int NOT NULL COMMENT '下单件数',
  `order_pay_count` int NOT NULL COMMENT '支付件数',
  `order_pay_price` int NOT NULL COMMENT '支付金额，单位：分',
  `after_sale_count` int NOT NULL COMMENT '退款件数',
  `after_sale_refund_price` int NOT NULL COMMENT '退款金额，单位：分',
  `browse_convert_percent` int NOT NULL COMMENT '访客支付转化率（百分比）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_time`(`time` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_article
-- ----------------------------
DROP TABLE IF EXISTS `promotion_article`;
CREATE TABLE `promotion_article`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章编号，主键自增',
  `category_id` bigint NOT NULL COMMENT '分类编号（关联 promotion_article_category.id）',
  `spu_id` bigint NULL DEFAULT NULL COMMENT '关联商品编号（关联 product_spu.id）',
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `author` varchar(255) NULL DEFAULT NULL COMMENT '文章作者',
  `pic_url` varchar(1024) NULL DEFAULT NULL COMMENT '文章封面图片地址',
  `introduction` varchar(512) NULL DEFAULT NULL COMMENT '文章简介',
  `browse_count` int NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `sort` int NOT NULL COMMENT '排序字段',
  `status` int NOT NULL COMMENT '状态（枚举 CommonStatusEnum）',
  `recommend_hot` tinyint(1) NOT NULL COMMENT '是否热门（0：否，1：是）',
  `recommend_banner` tinyint(1) NOT NULL COMMENT '是否轮播图（0：否，1：是）',
  `content` text NOT NULL COMMENT '文章内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_article
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_article_category
-- ----------------------------
DROP TABLE IF EXISTS `promotion_article_category`;
CREATE TABLE `promotion_article_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章分类编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '文章分类名称',
  `pic_url` varchar(1024) NULL DEFAULT NULL COMMENT '图标地址',
  `status` int NOT NULL COMMENT '状态（枚举 CommonStatusEnum）',
  `sort` int NOT NULL COMMENT '排序字段',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_article_category
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_banner
-- ----------------------------
DROP TABLE IF EXISTS `promotion_banner`;
CREATE TABLE `promotion_banner`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Banner 编号，主键自增',
  `title` varchar(255) NOT NULL COMMENT 'Banner 标题',
  `url` varchar(1024) NOT NULL COMMENT '跳转链接',
  `pic_url` varchar(1024) NOT NULL COMMENT '图片链接',
  `sort` int NOT NULL COMMENT '排序字段',
  `status` int NOT NULL COMMENT '状态（枚举 CommonStatusEnum）',
  `position` int NOT NULL COMMENT '定位（枚举 BannerPositionEnum）',
  `memo` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `browse_count` int NOT NULL DEFAULT 0 COMMENT '点击次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Banner 管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_banner
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_bargain_activity
-- ----------------------------
DROP TABLE IF EXISTS `promotion_bargain_activity`;
CREATE TABLE `promotion_bargain_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '砍价活动编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '砍价活动名称',
  `start_time` datetime NOT NULL COMMENT '活动开始时间',
  `end_time` datetime NOT NULL COMMENT '活动结束时间',
  `status` int NOT NULL COMMENT '活动状态（枚举 CommonStatusEnum）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `bargain_first_price` int NOT NULL COMMENT '砍价起始价格，单位：分',
  `bargain_min_price` int NOT NULL COMMENT '砍价底价，单位：分',
  `stock` int NOT NULL COMMENT '当前剩余库存',
  `total_stock` int NOT NULL COMMENT '总库存',
  `help_max_count` int NOT NULL COMMENT '需要多少人帮砍才能成功',
  `bargain_count` int NOT NULL COMMENT '单个用户可帮砍次数',
  `total_limit_count` int NOT NULL COMMENT '总限购数量',
  `random_min_price` int NOT NULL COMMENT '每次砍价最小金额，单位：分',
  `random_max_price` int NOT NULL COMMENT '每次砍价最大金额，单位：分',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '砍价活动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_bargain_activity
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_bargain_help
-- ----------------------------
DROP TABLE IF EXISTS `promotion_bargain_help`;
CREATE TABLE `promotion_bargain_help`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '砍价助力编号，主键自增',
  `activity_id` bigint NOT NULL COMMENT '砍价活动编号（关联 promotion_bargain_activity.id）',
  `record_id` bigint NOT NULL COMMENT '砍价记录编号（关联 promotion_bargain_record.id）',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `reduce_price` int NOT NULL COMMENT '减少价格，单位：分',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_record_id`(`record_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '砍价助力表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_bargain_help
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_bargain_record
-- ----------------------------
DROP TABLE IF EXISTS `promotion_bargain_record`;
CREATE TABLE `promotion_bargain_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '砍价记录编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `activity_id` bigint NOT NULL COMMENT '砍价活动编号（关联 promotion_bargain_activity.id）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `bargain_first_price` int NOT NULL COMMENT '砍价起始价格，单位：分',
  `bargain_price` int NOT NULL COMMENT '当前砍价价格，单位：分',
  `status` int NOT NULL COMMENT '砍价状态（枚举 BargainRecordStatusEnum）',
  `end_time` datetime NULL DEFAULT NULL COMMENT '砍价结束时间',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '砍价记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_bargain_record
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_combination_activity
-- ----------------------------
DROP TABLE IF EXISTS `promotion_combination_activity`;
CREATE TABLE `promotion_combination_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '拼团活动编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '拼团活动名称',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `total_limit_count` int NOT NULL COMMENT '总限购数量',
  `single_limit_count` int NOT NULL COMMENT '单次限购数量',
  `start_time` datetime NOT NULL COMMENT '活动开始时间',
  `end_time` datetime NOT NULL COMMENT '活动结束时间',
  `user_size` int NOT NULL COMMENT '成团人数',
  `virtual_group` int NOT NULL COMMENT '虚拟成团人数',
  `status` int NOT NULL COMMENT '活动状态（枚举 PromotionActivityStatusEnum）',
  `limit_duration` int NOT NULL COMMENT '成团限时，单位：秒',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_combination_activity
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_combination_product
-- ----------------------------
DROP TABLE IF EXISTS `promotion_combination_product`;
CREATE TABLE `promotion_combination_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '拼团商品编号，主键自增',
  `activity_id` bigint NOT NULL COMMENT '拼团活动编号（关联 promotion_combination_activity.id）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `combination_price` int NOT NULL COMMENT '拼团价格，单位：分',
  `activity_status` int NOT NULL COMMENT '拼团活动状态（冗余 promotion_combination_activity.status）',
  `activity_start_time` datetime NOT NULL COMMENT '拼团活动开始时间（冗余 promotion_combination_activity.start_time）',
  `activity_end_time` datetime NOT NULL COMMENT '拼团活动结束时间（冗余 promotion_combination_activity.end_time）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE,
  INDEX `idx_activity_start_time`(`activity_start_time` ASC) USING BTREE,
  INDEX `idx_activity_end_time`(`activity_end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '拼团商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_combination_product
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_combination_record
-- ----------------------------
DROP TABLE IF EXISTS `promotion_combination_record`;
CREATE TABLE `promotion_combination_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '拼团记录编号，主键自增',
  `activity_id` bigint NOT NULL COMMENT '拼团活动编号（关联 promotion_combination_activity.id）',
  `combination_price` int NOT NULL COMMENT '拼团价格，单位：分',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `spu_name` varchar(255) NOT NULL COMMENT '商品名称',
  `pic_url` varchar(1024) NULL DEFAULT NULL COMMENT '商品图片地址',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `count` int NOT NULL COMMENT '购买的商品数量',
  `userId` bigint NOT NULL COMMENT '用户编号',
  `nickname` varchar(255) NOT NULL COMMENT '用户昵称',
  `avatar` varchar(1024) NULL DEFAULT NULL COMMENT '用户头像地址',
  `head_id` bigint NOT NULL COMMENT '团长编号（关联 promotion_combination_record.id），0 表示团长',
  `status` int NOT NULL COMMENT '开团状态（枚举 CombinationRecordStatusEnum）',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单编号（关联 trade_order.id）',
  `user_size` int NOT NULL COMMENT '开团需要人数',
  `user_count` int NOT NULL COMMENT '已加入拼团人数',
  `virtual_group` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否虚拟成团（0：否，1：是）',
  `expire_time` datetime NOT NULL COMMENT '过期时间（startTime + limitDuration）',
  `start_time` datetime NOT NULL COMMENT '开始时间（订单付款后开始的时间）',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间（成团时间/失败时间）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`userId` ASC) USING BTREE,
  INDEX `idx_head_id`(`head_id` ASC) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_expire_time`(`expire_time` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '拼团记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_combination_record
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_coupon
-- ----------------------------
DROP TABLE IF EXISTS `promotion_coupon`;
CREATE TABLE `promotion_coupon`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '优惠券编号，主键自增',
  `template_id` bigint NOT NULL COMMENT '优惠券模板编号（关联 promotion_coupon_template.id）',
  `name` varchar(255) NOT NULL COMMENT '优惠券名称（冗余模板名称）',
  `status` int NOT NULL COMMENT '优惠券状态（枚举 CouponStatusEnum）',
  `user_id` bigint NOT NULL COMMENT '用户编号（关联 member_user.id）',
  `take_type` int NOT NULL COMMENT '领取类型（枚举 CouponTakeTypeEnum）',
  `use_price` int NOT NULL COMMENT '满多少金额可用，单位：分',
  `valid_start_time` datetime NOT NULL COMMENT '生效开始时间',
  `valid_end_time` datetime NOT NULL COMMENT '生效结束时间',
  `product_scope` int NOT NULL COMMENT '商品范围（枚举 PromotionProductScopeEnum）',
  `product_scope_values` varchar(2048) NULL COMMENT '商品范围编号数组（JSON 格式）',
  `discount_type` int NOT NULL COMMENT '折扣类型（枚举 PromotionDiscountTypeEnum）',
  `discount_percent` int NULL DEFAULT NULL COMMENT '折扣百分比（仅在 discountType 为 percent 时有效）',
  `discount_price` int NULL DEFAULT NULL COMMENT '优惠金额，单位：分（仅在 discountType 为 price 时有效）',
  `discount_limit_price` int NULL DEFAULT NULL COMMENT '折扣上限，仅在 discountType 为 percent 时有效',
  `use_order_id` bigint NULL DEFAULT NULL COMMENT '使用订单编号',
  `use_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_template_id`(`template_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_use_order_id`(`use_order_id` ASC) USING BTREE,
  INDEX `idx_valid_start_time`(`valid_start_time` ASC) USING BTREE,
  INDEX `idx_valid_end_time`(`valid_end_time` ASC) USING BTREE,
  INDEX `idx_use_time`(`use_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_coupon_template
-- ----------------------------
DROP TABLE IF EXISTS `promotion_coupon_template`;
CREATE TABLE `promotion_coupon_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '优惠券模板编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '优惠券名称',
  `description` varchar(512) NULL DEFAULT NULL COMMENT '优惠券说明',
  `status` int NOT NULL COMMENT '状态（枚举 CommonStatusEnum）',
  `total_count` int NOT NULL COMMENT '发放总数量（-1 表示不限制）',
  `take_limit_count` int NOT NULL COMMENT '每人限领个数（-1 表示不限制）',
  `take_type` int NOT NULL COMMENT '领取方式（枚举 CouponTakeTypeEnum）',
  `use_price` int NOT NULL COMMENT '满多少金额可用，单位：分',
  `product_scope` int NOT NULL COMMENT '商品范围（枚举 PromotionProductScopeEnum）',
  `product_scope_values` varchar(2048) NULL COMMENT '商品范围编号数组（JSON 格式）',
  `validity_type` int NOT NULL COMMENT '有效期类型（枚举 CouponTemplateValidityTypeEnum）',
  `valid_start_time` datetime NULL DEFAULT NULL COMMENT '固定生效开始时间（当 validityType 为 DATE 时有效）',
  `valid_end_time` datetime NULL DEFAULT NULL COMMENT '固定生效结束时间（当 validityType 为 DATE 时有效）',
  `fixed_start_term` int NULL DEFAULT NULL COMMENT '领取后开始天数（当 validityType 为 TERM 时有效）',
  `fixed_end_term` int NULL DEFAULT NULL COMMENT '领取后结束天数（当 validityType 为 TERM 时有效）',
  `discount_type` int NOT NULL COMMENT '折扣类型（枚举 PromotionDiscountTypeEnum）',
  `discount_percent` int NULL DEFAULT NULL COMMENT '折扣百分比（仅在 discountType 为 PERCENT 时有效）',
  `discount_price` int NULL DEFAULT NULL COMMENT '优惠金额，单位：分（仅在 discountType 为 PRICE 时有效）',
  `discount_limit_price` int NULL DEFAULT NULL COMMENT '折扣上限金额（仅在 discountType 为 PERCENT 时有效）',
  `take_count` int NOT NULL DEFAULT 0 COMMENT '已领取数量',
  `use_count` int NOT NULL DEFAULT 0 COMMENT '已使用数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_take_type`(`take_type` ASC) USING BTREE,
  INDEX `idx_validity_type`(`validity_type` ASC) USING BTREE,
  INDEX `idx_discount_type`(`discount_type` ASC) USING BTREE,
  INDEX `idx_valid_start_time`(`valid_start_time` ASC) USING BTREE,
  INDEX `idx_valid_end_time`(`valid_end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_coupon_template
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_discount_activity
-- ----------------------------
DROP TABLE IF EXISTS `promotion_discount_activity`;
CREATE TABLE `promotion_discount_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '限时折扣活动编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '活动标题',
  `status` int NOT NULL COMMENT '活动状态（枚举 CommonStatusEnum）',
  `start_time` datetime NOT NULL COMMENT '活动开始时间',
  `end_time` datetime NOT NULL COMMENT '活动结束时间',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '限时折扣活动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_discount_activity
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_discount_product
-- ----------------------------
DROP TABLE IF EXISTS `promotion_discount_product`;
CREATE TABLE `promotion_discount_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '限时折扣商品编号，主键自增',
  `activity_id` bigint NOT NULL COMMENT '关联活动编号（promotion_discount_activity.id）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `discount_type` int NOT NULL COMMENT '折扣类型（枚举 PromotionDiscountTypeEnum）',
  `discount_percent` int NULL DEFAULT NULL COMMENT '折扣百分比（仅在 discountType 为 PERCENT 时有效）',
  `discount_price` int NULL DEFAULT NULL COMMENT '优惠金额，单位：分（仅在 discountType 为 PRICE 时有效）',
  `activity_name` varchar(255) NOT NULL COMMENT '活动标题（冗余 promotion_discount_activity.name）',
  `activity_status` int NOT NULL COMMENT '活动状态（冗余 promotion_discount_activity.status）',
  `activity_start_time` datetime NOT NULL COMMENT '活动开始时间（冗余 promotion_discount_activity.start_time）',
  `activity_end_time` datetime NOT NULL COMMENT '活动结束时间（冗余 promotion_discount_activity.end_time）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE,
  INDEX `idx_activity_status`(`activity_status` ASC) USING BTREE,
  INDEX `idx_activity_start_time`(`activity_start_time` ASC) USING BTREE,
  INDEX `idx_activity_end_time`(`activity_end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '限时折扣商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_discount_product
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_diy_page
-- ----------------------------
DROP TABLE IF EXISTS `promotion_diy_page`;
CREATE TABLE `promotion_diy_page`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '装修页面编号，主键自增',
  `template_id` bigint NULL DEFAULT NULL COMMENT '装修模板编号（关联 promotion_diy_template.id）',
  `name` varchar(255) NOT NULL COMMENT '页面名称',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `preview_pic_urls` varchar(1024) NULL COMMENT '预览图数组（JSON 格式）',
  `property` text NULL COMMENT '页面属性，JSON 格式',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_template_id`(`template_id` ASC) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '装修页面表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_diy_page
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_diy_template
-- ----------------------------
DROP TABLE IF EXISTS `promotion_diy_template`;
CREATE TABLE `promotion_diy_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '装修模板编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '模板名称',
  `used` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否使用（0：未使用，1：已使用）',
  `used_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `preview_pic_urls` varchar(1024) NULL COMMENT '预览图数组（JSON 格式）',
  `property` text NULL COMMENT 'uni-app 底部导航属性，JSON 格式',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者（SysUser 的 id 编号）',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者（SysUser 的 id 编号）',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除（0：未删除，1：已删除）',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE,
  INDEX `idx_used`(`used` ASC) USING BTREE,
  INDEX `idx_used_time`(`used_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '装修模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_diy_template
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_kefu_conversation
-- ----------------------------
DROP TABLE IF EXISTS `promotion_kefu_conversation`;
CREATE TABLE `promotion_kefu_conversation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '客服会话编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '会话所属用户（member_user.id）',
  `last_message_time` datetime NULL DEFAULT NULL COMMENT '最后聊天时间',
  `last_message_content` text NULL COMMENT '最后聊天内容',
  `last_message_content_type` int NULL DEFAULT NULL COMMENT '最后发送的消息类型（枚举 KeFuMessageContentTypeEnum）',
  `admin_pinned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '管理端是否置顶',
  `user_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '用户是否删除（0：可见，1：不可见）',
  `admin_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '管理员是否删除（0：可见，1：不可见）',
  `admin_unread_message_count` int NOT NULL DEFAULT 0 COMMENT '管理员未读消息数',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_last_message_time`(`last_message_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客服会话表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_kefu_conversation
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_kefu_message
-- ----------------------------
DROP TABLE IF EXISTS `promotion_kefu_message`;
CREATE TABLE `promotion_kefu_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '客服消息编号，主键自增',
  `conversation_id` bigint NOT NULL COMMENT '关联会话编号（promotion_kefu_conversation.id）',
  `sender_id` bigint NOT NULL COMMENT '发送人编号（用户或管理员）',
  `sender_type` int NOT NULL COMMENT '发送人类型（枚举 UserTypeEnum）',
  `receiver_id` bigint NOT NULL COMMENT '接收人编号（用户或管理员）',
  `receiver_type` int NOT NULL COMMENT '接收人类型（枚举 UserTypeEnum）',
  `content_type` int NOT NULL COMMENT '消息类型（枚举 KeFuMessageContentTypeEnum）',
  `content` text NOT NULL COMMENT '消息内容',
  `read_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已读（0：未读，1：已读）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_conversation_id`(`conversation_id` ASC) USING BTREE,
  INDEX `idx_sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `idx_receiver_id`(`receiver_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客服消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_kefu_message
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_point_activity
-- ----------------------------
DROP TABLE IF EXISTS `promotion_point_activity`;
CREATE TABLE `promotion_point_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '积分商城活动编号，主键自增',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `status` int NOT NULL COMMENT '活动状态（枚举 CommonStatusEnum）',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `sort` int NOT NULL COMMENT '排序字段',
  `stock` int NOT NULL COMMENT '剩余库存',
  `total_stock` int NOT NULL COMMENT '总库存',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '积分商城活动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_point_activity
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_point_product
-- ----------------------------
DROP TABLE IF EXISTS `promotion_point_product`;
CREATE TABLE `promotion_point_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '积分商城商品编号，主键自增',
  `activity_id` bigint NOT NULL COMMENT '关联活动编号（promotion_point_activity.id）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `count` int NOT NULL COMMENT '可兑换次数',
  `point` int NOT NULL COMMENT '所需兑换积分',
  `price` int NOT NULL COMMENT '所需兑换金额，单位：分',
  `stock` int NOT NULL COMMENT '积分商城商品库存',
  `activity_status` int NOT NULL COMMENT '积分商城商品状态（关联 promotion_point_activity.status）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '积分商城商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_point_product
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_reward_activity
-- ----------------------------
DROP TABLE IF EXISTS `promotion_reward_activity`;
CREATE TABLE `promotion_reward_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '满减送活动编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '活动名称',
  `status` int NOT NULL COMMENT '活动状态（枚举 CommonStatusEnum）',
  `start_time` datetime NOT NULL COMMENT '活动开始时间',
  `end_time` datetime NOT NULL COMMENT '活动结束时间',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `condition_type` int NOT NULL COMMENT '条件类型（枚举 PromotionConditionTypeEnum）',
  `product_scope` int NOT NULL COMMENT '商品范围（枚举 PromotionProductScopeEnum）',
  `product_scope_values` varchar(2048) NULL COMMENT '商品范围值（SPU ID 列表）',
  `rules` varchar(2048) NOT NULL COMMENT '优惠规则（JSON 格式）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_condition_type`(`condition_type` ASC) USING BTREE,
  INDEX `idx_product_scope`(`product_scope` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '满减送活动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_reward_activity
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_seckill_activity
-- ----------------------------
DROP TABLE IF EXISTS `promotion_seckill_activity`;
CREATE TABLE `promotion_seckill_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '秒杀活动编号，主键自增',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `name` varchar(255) NOT NULL COMMENT '活动名称',
  `status` int NOT NULL COMMENT '活动状态（枚举 CommonStatusEnum）',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `start_time` datetime NOT NULL COMMENT '活动开始时间',
  `end_time` datetime NOT NULL COMMENT '活动结束时间',
  `sort` int NOT NULL COMMENT '排序字段',
  `config_ids` varchar(2048) NULL COMMENT '关联的秒杀时段 ID 列表（JSON 格式）',
  `total_limit_count` int NOT NULL COMMENT '总限购数量',
  `single_limit_count` int NOT NULL COMMENT '单次限购数量',
  `stock` int NOT NULL COMMENT '当前库存',
  `total_stock` int NOT NULL COMMENT '总库存',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '秒杀活动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_seckill_activity
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_seckill_config
-- ----------------------------
DROP TABLE IF EXISTS `promotion_seckill_config`;
CREATE TABLE `promotion_seckill_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '秒杀时段编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '时段名称',
  `start_time` time NOT NULL COMMENT '开始时间点（格式 HH:mm:ss）',
  `end_time` time NOT NULL COMMENT '结束时间点（格式 HH:mm:ss）',
  `slider_pic_urls` varchar(2048) NULL COMMENT '轮播图 URL 列表（JSON 格式）',
  `status` int NOT NULL COMMENT '状态（枚举 CommonStatusEnum）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '秒杀时段配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_seckill_config
-- ----------------------------

-- ----------------------------
-- Table structure for promotion_seckill_product
-- ----------------------------
DROP TABLE IF EXISTS `promotion_seckill_product`;
CREATE TABLE `promotion_seckill_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '秒杀商品编号，主键自增',
  `activity_id` bigint NOT NULL COMMENT '关联活动编号（promotion_seckill_activity.id）',
  `config_ids` varchar(2048) NULL COMMENT '关联的秒杀时段 ID 列表（JSON 格式）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `seckill_price` int NOT NULL COMMENT '秒杀金额，单位：分',
  `stock` int NOT NULL COMMENT '秒杀库存',
  `activity_status` int NOT NULL COMMENT '活动状态（枚举 CommonStatusEnum）',
  `activity_start_time` datetime NOT NULL COMMENT '活动开始时间（冗余 promotion_seckill_activity.start_time）',
  `activity_end_time` datetime NOT NULL COMMENT '活动结束时间（冗余 promotion_seckill_activity.end_time）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE,
  INDEX `idx_activity_status`(`activity_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '秒杀参与商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotion_seckill_product
-- ----------------------------

-- ----------------------------
-- Table structure for system_dept
-- ----------------------------
DROP TABLE IF EXISTS `system_dept`;
CREATE TABLE `system_dept`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父部门id',
  `sort` int NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `leader_user_id` bigint NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL COMMENT '部门状态（0正常 1停用）',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_dept
-- ----------------------------
INSERT INTO `ruoyi-vue-pro`.`system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '安泉到家', 0, 0, 1, '16666666666', 'anquandaojia@qq.com', 0, '1', '2025-06-20 00:00:00', '1', '2025-06-20 00:00:00', b'0', 1);

-- ----------------------------
-- Table structure for system_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `system_dict_data`;
CREATE TABLE `system_dict_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `sort` int NOT NULL DEFAULT 0 COMMENT '字典排序',
  `label` varchar(100) NOT NULL DEFAULT '' COMMENT '字典标签',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态（0正常 1停用）',
  `color_type` varchar(100) NULL DEFAULT '' COMMENT '颜色类型',
  `css_class` varchar(100) NULL DEFAULT '' COMMENT 'css 样式',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3003 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_dict_data
-- ----------------------------
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, 0, '工商银行', '0', 'brokerage_bank_name', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 1, '建设银行', '1', 'brokerage_bank_name', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3, 2, '农业银行', '2', 'brokerage_bank_name', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (4, 3, '中国银行', '3', 'brokerage_bank_name', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (5, 4, '交通银行', '4', 'brokerage_bank_name', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (6, 5, '招商银行', '5', 'brokerage_bank_name', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (7, 1, '首次绑定', '1', 'brokerage_bind_mode', 0, '', '', '只要用户没有推广人，随时都可以绑定推广关系', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 2, '注册绑定', '2', 'brokerage_bind_mode', 0, '', '', '仅新用户注册时才能绑定推广关系', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, 3, '覆盖绑定', '3', 'brokerage_bind_mode', 0, '', '', '如果用户已经有推广人，推广人会被变更', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (10, 1, '人人分销', '1', 'brokerage_enabled_condition', 0, '', '', '所有用户都可以分销', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (11, 2, '指定分销', '2', 'brokerage_enabled_condition', 0, '', '', '仅可后台手动设置推广员', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (12, 1, '订单返佣', '1', 'brokerage_record_biz_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, 2, '申请提现', '2', 'brokerage_record_biz_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, 3, '申请提现驳回', '3', 'brokerage_record_biz_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, 0, '待结算', '0', 'brokerage_record_status', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (16, 1, '已结算', '1', 'brokerage_record_status', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (17, 2, '已取消', '2', 'brokerage_record_status', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (18, 0, '审核中', '0', 'brokerage_withdraw_status', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (19, 10, '审核通过', '10', 'brokerage_withdraw_status', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (20, 11, '提现成功', '11', 'brokerage_withdraw_status', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (21, 20, '审核不通过', '20', 'brokerage_withdraw_status', 0, 'danger', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (22, 21, '提现失败', '21', 'brokerage_withdraw_status', 0, 'danger', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (23, 1, '钱包', '1', 'brokerage_withdraw_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (24, 2, '银行卡', '2', 'brokerage_withdraw_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (25, 3, '微信收款码', '3', 'brokerage_withdraw_type', 0, '', '', '手动打款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (26, 4, '支付宝收款码', '4', 'brokerage_withdraw_type', 0, '', '', '手动打款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (27, 5, '微信零钱', '5', 'brokerage_withdraw_type', 0, '', '', 'API 打款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (28, 6, '支付宝余额', '6', 'brokerage_withdraw_type', 0, '', '', 'API 打款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (29, 1, '开启', '0', 'common_status', 0, 'primary', '', '开启状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (30, 2, '关闭', '1', 'common_status', 0, 'info', '', '关闭状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (31, 1, '天', '1', 'date_interval', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (32, 2, '周', '2', 'date_interval', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (33, 3, '月', '3', 'date_interval', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (34, 4, '季度', '4', 'date_interval', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (35, 5, '年', '5', 'date_interval', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (36, 0, '未处理', '0', 'infra_api_error_log_process_status', 0, 'primary', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (37, 1, '已处理', '1', 'infra_api_error_log_process_status', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (38, 2, '已忽略', '2', 'infra_api_error_log_process_status', 0, 'danger', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (39, 1, '是', 'true', 'infra_boolean_string', 0, 'danger', '', 'Boolean 是否类型 - 是', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (40, 1, '否', 'false', 'infra_boolean_string', 0, 'info', '', 'Boolean 是否类型 - 否', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, 10, 'Vue2 Element UI 标准模版', '10', 'infra_codegen_front_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, 20, 'Vue3 Element Plus 标准模版', '20', 'infra_codegen_front_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (43, 30, 'Vben2.0 Ant Design Schema 模版', '30', 'infra_codegen_front_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (44, 50, 'Vben5.0 Ant Design Schema 模版', '40', 'infra_codegen_front_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (45, 1, '管理后台', '1', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 管理后台', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (46, 2, '用户 APP', '2', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 用户 APP', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (47, 1, '单表（增删改查）', '1', 'infra_codegen_template_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (48, 2, '树表（增删改查）', '2', 'infra_codegen_template_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (49, 15, '子表', '15', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (50, 10, '主表（标准模式）', '10', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (51, 11, '主表（ERP 模式）', '11', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (52, 12, '主表（内嵌模式）', '12', 'infra_codegen_template_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (53, 1, '系统内置', '1', 'infra_config_type', 0, 'danger', '', '参数类型 - 系统内置', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (54, 2, '自定义', '2', 'infra_config_type', 0, 'primary', '', '参数类型 - 自定义', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (55, 1, '数据库', '1', 'infra_file_storage', 0, 'default', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (56, 10, '本地磁盘', '10', 'infra_file_storage', 0, 'default', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (57, 11, 'FTP 服务器', '11', 'infra_file_storage', 0, 'default', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (58, 12, 'SFTP 服务器', '12', 'infra_file_storage', 0, 'default', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (59, 20, 'S3 对象存储', '20', 'infra_file_storage', 0, 'default', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (60, 0, '运行中', '0', 'infra_job_log_status', 0, 'primary', '', 'RUNNING', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (61, 1, '成功', '1', 'infra_job_log_status', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (62, 2, '失败', '2', 'infra_job_log_status', 0, 'warning', '', '失败', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (63, 1, '正常', '1', 'infra_job_status', 0, 'success', '', '正常状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (64, 2, '暂停', '2', 'infra_job_status', 0, 'danger', '', '停用状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (65, 0, '初始化中', '0', 'infra_job_status', 0, 'primary', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (66, 0, '其它', '0', 'infra_operate_type', 0, 'default', '', '其它操作', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (67, 1, '查询', '1', 'infra_operate_type', 0, 'info', '', '查询操作', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (68, 2, '新增', '2', 'infra_operate_type', 0, 'primary', '', '新增操作', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (69, 3, '修改', '3', 'infra_operate_type', 0, 'warning', '', '修改操作', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (70, 4, '删除', '4', 'infra_operate_type', 0, 'danger', '', '删除操作', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (71, 5, '导出', '5', 'infra_operate_type', 0, 'default', '', '导出操作', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (72, 6, '导入', '6', 'infra_operate_type', 0, 'default', '', '导入操作', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (73, 0, '管理员调整', '0', 'member_experience_biz_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (74, 1, '邀新奖励', '1', 'member_experience_biz_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (75, 11, '下单奖励', '11', 'member_experience_biz_type', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (76, 12, '下单奖励（整单取消）', '12', 'member_experience_biz_type', 0, 'warning', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (77, 4, '签到奖励', '4', 'member_experience_biz_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (78, 5, '抽奖奖励', '5', 'member_experience_biz_type', 0, '', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (79, 13, '下单奖励（单个退款）', '13', 'member_experience_biz_type', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (80, 11, '订单积分抵扣', '11', 'member_point_biz_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (81, 1, '签到', '1', 'member_point_biz_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (82, 12, '订单积分抵扣（整单取消）', '12', 'member_point_biz_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (83, 2, '管理员修改', '2', 'member_point_biz_type', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (84, 13, '订单积分抵扣（单个退款）', '13', 'member_point_biz_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (85, 21, '订单积分奖励', '21', 'member_point_biz_type', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (86, 22, '订单积分奖励（整单取消）', '22', 'member_point_biz_type', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (87, 23, '订单积分奖励（单个退款）', '23', 'member_point_biz_type', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (88, 0, '微信 Wap 网站支付', 'wx_wap', 'pay_channel_code', 0, 'success', '', '微信 Wap 网站支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (89, 1, '微信公众号支付', 'wx_pub', 'pay_channel_code', 0, 'success', '', '微信公众号支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (90, 2, '微信小程序支付', 'wx_lite', 'pay_channel_code', 0, 'success', '', '微信小程序支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (91, 3, '微信 App 支付', 'wx_app', 'pay_channel_code', 0, 'success', '', '微信 App 支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (92, 10, '支付宝 PC 网站支付', 'alipay_pc', 'pay_channel_code', 0, 'primary', '', '支付宝 PC 网站支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (93, 11, '支付宝 Wap 网站支付', 'alipay_wap', 'pay_channel_code', 0, 'primary', '', '支付宝 Wap 网站支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (94, 12, '支付宝 App 支付', 'alipay_app', 'pay_channel_code', 0, 'primary', '', '支付宝 App 支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (95, 14, '支付宝扫码支付', 'alipay_qr', 'pay_channel_code', 0, 'primary', '', '支付宝扫码支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (96, 13, '支付宝条码支付', 'alipay_bar', 'pay_channel_code', 0, 'primary', '', '支付宝条码支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (97, 4, '微信扫码支付', 'wx_native', 'pay_channel_code', 0, 'success', '', '微信扫码支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (98, 5, '微信条码支付', 'wx_bar', 'pay_channel_code', 0, 'success', '', '微信条码支付\n', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (99, 20, '模拟支付', 'mock', 'pay_channel_code', 0, 'default', '', '模拟支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (100, 21, '钱包', 'wallet', 'pay_channel_code', 0, 'primary', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (101, 10, '通知成功', '10', 'pay_notify_status', 0, 'success', '', '通知成功', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (102, 20, '通知失败', '20', 'pay_notify_status', 0, 'danger', '', '通知失败', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (103, 0, '等待通知', '0', 'pay_notify_status', 0, 'info', '', '未通知', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (104, 21, '请求成功，但是结果失败', '21', 'pay_notify_status', 0, 'warning', '', '请求成功，但是结果失败', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (105, 22, '请求失败', '22', 'pay_notify_status', 0, 'warning', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (106, 1, '支付单', '1', 'pay_notify_type', 0, 'primary', '', '支付单', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (107, 2, '退款单', '2', 'pay_notify_type', 0, 'danger', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (108, 10, '支付成功', '10', 'pay_order_status', 0, 'success', '', '支付成功', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (109, 30, '支付关闭', '30', 'pay_order_status', 0, 'info', '', '支付关闭', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (110, 0, '等待支付', '0', 'pay_order_status', 0, 'info', '', '未支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (111, 20, '已退款', '20', 'pay_order_status', 0, 'danger', '', '已退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (112, 0, '等待退款', '0', 'pay_refund_status', 0, 'info', '', '等待退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (113, 20, '退款失败', '20', 'pay_refund_status', 0, 'danger', '', '退款失败', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (114, 10, '退款成功', '10', 'pay_refund_status', 0, 'success', '', '退款成功', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (115, 4, '转账失败', '20', 'pay_transfer_status', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (116, 3, '转账成功', '10', 'pay_transfer_status', 0, 'success', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (117, 2, '转账进行中', '5', 'pay_transfer_status', 0, 'info', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (118, 1, '等待转账', '0', 'pay_transfer_status', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (119, 1, '销售中', '1', 'product_spu_status', 0, 'success', '', '商品 SPU 状态 - 销售中', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (120, 0, '仓库中', '0', 'product_spu_status', 0, 'info', '', '商品 SPU 状态 - 仓库中', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (121, 0, '回收站', '-1', 'product_spu_status', 0, 'default', '', '商品 SPU 状态 - 回收站', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (122, 10, '未开始', '10', 'promotion_activity_status', 0, 'primary', '', '促销活动的状态枚举 - 未开始', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (123, 20, '进行中', '20', 'promotion_activity_status', 0, 'success', '', '促销活动的状态枚举 - 进行中', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (124, 30, '已结束', '30', 'promotion_activity_status', 0, 'info', '', '促销活动的状态枚举 - 已结束', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (125, 40, '已关闭', '40', 'promotion_activity_status', 0, 'warning', '', '促销活动的状态枚举 - 已关闭', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (126, 5, '首页', '1', 'promotion_banner_position', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (127, 4, '秒杀活动页', '2', 'promotion_banner_position', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (128, 3, '砍价活动页', '3', 'promotion_banner_position', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (129, 2, '限时折扣页', '4', 'promotion_banner_position', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (130, 1, '满减送页', '5', 'promotion_banner_position', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (131, 1, '砍价中', '1', 'promotion_bargain_record_status', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (132, 2, '砍价成功', '2', 'promotion_bargain_record_status', 0, 'success', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (133, 3, '砍价失败', '3', 'promotion_bargain_record_status', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (134, 0, '拼团中', '0', 'promotion_combination_record_status', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (135, 1, '拼团成功', '1', 'promotion_combination_record_status', 0, 'success', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (136, 2, '拼团失败', '2', 'promotion_combination_record_status', 0, 'warning', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (137, 10, '满 N 元', '10', 'promotion_condition_type', 0, 'primary', '', '营销的条件类型 - 满 N 元', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (138, 20, '满 N 件', '20', 'promotion_condition_type', 0, 'success', '', '营销的条件类型 - 满 N 件', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (139, 1, '未使用', '1', 'promotion_coupon_status', 0, 'primary', '', '优惠劵的状态 - 已领取', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (140, 2, '已使用', '2', 'promotion_coupon_status', 0, 'success', '', '优惠劵的状态 - 已使用', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (141, 3, '已过期', '3', 'promotion_coupon_status', 0, 'info', '', '优惠劵的状态 - 已过期', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (142, 1, '直接领取', '1', 'promotion_coupon_take_type', 0, 'primary', '', '优惠劵的领取方式 - 直接领取', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (143, 2, '指定发放', '2', 'promotion_coupon_take_type', 0, 'success', '', '优惠劵的领取方式 - 指定发放', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (144, 3, '新人券', '3', 'promotion_coupon_take_type', 0, 'info', '', '新人注册后，自动发放', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (145, 1, '固定日期', '1', 'promotion_coupon_template_validity_type', 0, 'default', '', '优惠劵模板的有限期类型 - 固定日期', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (146, 2, '领取之后', '2', 'promotion_coupon_template_validity_type', 0, 'default', '', '优惠劵模板的有限期类型 - 领取之后', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (147, 1, '满减', '1', 'promotion_discount_type', 0, 'success', '', '优惠类型 - 满减', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (148, 2, '折扣', '2', 'promotion_discount_type', 0, 'primary', '', '优惠类型 - 折扣', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (149, 1, '通用劵', '1', 'promotion_product_scope', 0, 'default', '', '营销的商品范围 - 全部商品参与', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (150, 2, '商品劵', '2', 'promotion_product_scope', 0, 'default', '', '营销的商品范围 - 指定商品参与', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (151, 3, '品类劵', '3', 'promotion_product_scope', 0, 'default', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (152, 1, '全部数据权限', '1', 'system_data_scope', 0, '', '', '全部数据权限', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (153, 2, '指定部门数据权限', '2', 'system_data_scope', 0, '', '', '指定部门数据权限', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (154, 3, '本部门数据权限', '3', 'system_data_scope', 0, '', '', '本部门数据权限', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (155, 4, '本部门及以下数据权限', '4', 'system_data_scope', 0, '', '', '本部门及以下数据权限', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (156, 5, '仅本人数据权限', '5', 'system_data_scope', 0, '', '', '仅本人数据权限', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (157, 0, '成功', '0', 'system_login_result', 0, 'success', '', '登陆结果 - 成功', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (158, 10, '账号或密码不正确', '10', 'system_login_result', 0, 'primary', '', '登陆结果 - 账号或密码不正确', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (159, 20, '用户被禁用', '20', 'system_login_result', 0, 'warning', '', '登陆结果 - 用户被禁用', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (160, 30, '验证码不存在', '30', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不存在', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (161, 31, '验证码不正确', '31', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不正确', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (162, 100, '未知异常', '100', 'system_login_result', 0, 'danger', '', '登陆结果 - 未知异常', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (163, 100, '账号登录', '100', 'system_login_type', 0, 'primary', '', '账号登录', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (164, 101, '社交登录', '101', 'system_login_type', 0, 'info', '', '社交登录', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (165, 200, '主动登出', '200', 'system_login_type', 0, 'primary', '', '主动登出', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (166, 202, '强制登出', '202', 'system_login_type', 0, 'danger', '', '强制退出', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (167, 103, '短信登录', '103', 'system_login_type', 0, 'default', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (168, 0, '初始化', '0', 'system_mail_send_status', 0, 'primary', '', '邮件发送状态 - 初始化\n', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (169, 10, '发送成功', '10', 'system_mail_send_status', 0, 'success', '', '邮件发送状态 - 发送成功', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (170, 20, '发送失败', '20', 'system_mail_send_status', 0, 'danger', '', '邮件发送状态 - 发送失败', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (171, 30, '不发送', '30', 'system_mail_send_status', 0, 'info', '', '邮件发送状态 -  不发送', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (172, 1, '目录', '1', 'system_menu_type', 0, '', '', '目录', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (173, 2, '菜单', '2', 'system_menu_type', 0, '', '', '菜单', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (174, 3, '按钮', '3', 'system_menu_type', 0, '', '', '按钮', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (175, 1, '通知', '1', 'system_notice_type', 0, 'success', '', '通知', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (176, 2, '公告', '2', 'system_notice_type', 0, 'info', '', '公告', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (177, 1, '通知公告', '1', 'system_notify_template_type', 0, 'primary', '', '站内信模版的类型 - 通知公告', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (178, 2, '系统消息', '2', 'system_notify_template_type', 0, 'success', '', '站内信模版的类型 - 系统消息', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (179, 1, 'password', 'password', 'system_oauth2_grant_type', 0, 'default', '', '密码模式', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (180, 2, 'authorization_code', 'authorization_code', 'system_oauth2_grant_type', 0, 'primary', '', '授权码模式', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (181, 3, 'implicit', 'implicit', 'system_oauth2_grant_type', 0, 'success', '', '简化模式', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (182, 4, 'client_credentials', 'client_credentials', 'system_oauth2_grant_type', 0, 'default', '', '客户端模式', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (183, 5, 'refresh_token', 'refresh_token', 'system_oauth2_grant_type', 0, 'info', '', '刷新模式', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (184, 1, '内置', '1', 'system_role_type', 0, 'danger', '', '内置角色', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (185, 2, '自定义', '2', 'system_role_type', 0, 'primary', '', '自定义角色', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (186, 1, '阿里云', 'ALIYUN', 'system_sms_channel_code', 0, 'primary', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (187, 0, '调试(钉钉)', 'DEBUG_DING_TALK', 'system_sms_channel_code', 0, 'info', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (188, 2, '腾讯云', 'TENCENT', 'system_sms_channel_code', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (189, 3, '华为云', 'HUAWEI', 'system_sms_channel_code', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (190, 4, '七牛云', 'QINIU', 'system_sms_channel_code', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (191, 0, '等待结果', '0', 'system_sms_receive_status', 0, 'primary', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (192, 1, '接收成功', '10', 'system_sms_receive_status', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (193, 2, '接收失败', '20', 'system_sms_receive_status', 0, 'danger', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (194, 0, '初始化', '0', 'system_sms_send_status', 0, 'primary', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (195, 1, '发送成功', '10', 'system_sms_send_status', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (196, 2, '发送失败', '20', 'system_sms_send_status', 0, 'danger', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (197, 3, '不发送', '30', 'system_sms_send_status', 0, 'info', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (198, 1, '验证码', '1', 'system_sms_template_type', 0, 'warning', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (199, 2, '通知', '2', 'system_sms_template_type', 0, 'primary', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (200, 0, '营销', '3', 'system_sms_template_type', 0, 'danger', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (201, 10, 'Gitee', '10', 'system_social_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (202, 20, '钉钉', '20', 'system_social_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (203, 30, '企业微信', '30', 'system_social_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (204, 31, '微信公众平台', '31', 'system_social_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (205, 32, '微信开放平台', '32', 'system_social_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (206, 34, '微信小程序', '34', 'system_social_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (207, 1, '男', '1', 'system_user_sex', 0, 'default', 'A', '性别男', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (208, 2, '女', '2', 'system_user_sex', 0, 'success', '', '性别女', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (209, 10, '微信小程序', '10', 'terminal', 0, 'default', '', '终端 - 微信小程序', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (210, 20, 'H5 网页', '20', 'terminal', 0, 'default', '', '终端 - H5 网页', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (211, 11, '微信公众号', '11', 'terminal', 0, 'default', '', '终端 - 微信公众号', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (212, 31, '苹果 App', '31', 'terminal', 0, 'default', '', '终端 - 苹果 App', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (213, 32, '安卓 App', '32', 'terminal', 0, 'default', '', '终端 - 安卓 App', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (214, 10, '申请售后', '10', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 申请售后', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (215, 20, '商品待退货', '20', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 商品待退货', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (216, 30, '商家待收货', '30', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 商家待收货', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (217, 40, '等待退款', '40', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 等待退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (218, 50, '退款成功', '50', 'trade_after_sale_status', 0, 'default', '', '交易售后状态 - 退款成功', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (219, 61, '买家取消', '61', 'trade_after_sale_status', 0, 'info', '', '交易售后状态 - 买家取消', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (220, 62, '商家拒绝', '62', 'trade_after_sale_status', 0, 'info', '', '交易售后状态 - 商家拒绝', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (221, 63, '商家拒收货', '63', 'trade_after_sale_status', 0, 'info', '', '交易售后状态 - 商家拒收货', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (222, 10, '售中退款', '10', 'trade_after_sale_type', 0, 'success', '', '交易售后的类型 - 售中退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (223, 20, '售后退款', '20', 'trade_after_sale_type', 0, 'primary', '', '交易售后的类型 - 售后退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (224, 10, '仅退款', '10', 'trade_after_sale_way', 0, 'primary', '', '交易售后的方式 - 仅退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (225, 20, '退货退款', '20', 'trade_after_sale_way', 0, 'success', '', '交易售后的方式 - 退货退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (226, 0, '按件', '1', 'trade_delivery_express_charge_mode', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (227, 1, '按重量', '2', 'trade_delivery_express_charge_mode', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (228, 2, '按体积', '3', 'trade_delivery_express_charge_mode', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (229, 1, '快递发货', '1', 'trade_delivery_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (230, 2, '用户自提', '2', 'trade_delivery_type', 0, '', '', '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (231, 0, '未售后', '0', 'trade_order_item_after_sale_status', 0, 'info', '', '交易订单项的售后状态 - 未售后', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (232, 10, '售后中', '10', 'trade_order_item_after_sale_status', 0, 'primary', '', '交易订单项的售后状态 - 售后中', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (233, 20, '已退款', '20', 'trade_order_item_after_sale_status', 0, 'success', '', '交易订单项的售后状态 - 已退款', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (234, 0, '待支付', '0', 'trade_order_status', 0, 'default', '', '交易订单状态 - 待支付', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (235, 10, '待发货', '10', 'trade_order_status', 0, 'primary', '', '交易订单状态 - 待发货', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (236, 20, '已发货', '20', 'trade_order_status', 0, 'primary', '', '交易订单状态 - 已发货', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (237, 30, '已完成', '30', 'trade_order_status', 0, 'success', '', '交易订单状态 - 已完成', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (238, 40, '已取消', '40', 'trade_order_status', 0, 'danger', '', '交易订单状态 - 已取消', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (239, 0, '普通订单', '0', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 普通订单', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (240, 1, '秒杀订单', '1', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 秒杀订单', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (241, 2, '砍价订单', '2', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 拼团订单', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (242, 3, '拼团订单', '3', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 砍价订单', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (243, 1, '会员', '1', 'user_type', 0, 'primary', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (244, 2, '管理员', '2', 'user_type', 0, 'success', '', NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');

-- ----------------------------
-- Table structure for system_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `system_dict_type`;
CREATE TABLE `system_dict_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '字典名称',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `deleted_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_dict_type
-- ----------------------------
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (1, '佣金提现银行', 'brokerage_bank_name', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (2, '分销关系绑定模式', 'brokerage_bind_mode', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (3, '分佣模式', 'brokerage_enabled_condition', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (4, '佣金记录业务类型', 'brokerage_record_biz_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (5, '佣金记录状态', 'brokerage_record_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (6, '佣金提现状态', 'brokerage_withdraw_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (7, '佣金提现类型', 'brokerage_withdraw_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (8, '系统状态', 'common_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (9, '时间间隔', 'date_interval', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (10, 'API 异常数据的处理状态', 'infra_api_error_log_process_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (11, 'Boolean 是否类型', 'infra_boolean_string', 0, 'boolean 转是否', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (12, '代码生成的前端类型', 'infra_codegen_front_type', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (13, '代码生成的场景枚举', 'infra_codegen_scene', 0, '代码生成的场景枚举', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (14, '代码生成模板类型', 'infra_codegen_template_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (15, '参数类型', 'infra_config_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (16, '文件存储器', 'infra_file_storage', 0, '文件存储器', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (17, '定时任务日志状态', 'infra_job_log_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (18, '定时任务状态', 'infra_job_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (19, '操作类型', 'infra_operate_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (20, '会员经验业务类型', 'member_experience_biz_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (21, '积分业务类型', 'member_point_biz_type', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (22, '支付渠道编码类型', 'pay_channel_code', 0, '支付渠道的编码', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (23, '支付回调状态', 'pay_notify_status', 0, '支付回调状态（包括退款回调）', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (24, '支付通知类型', 'pay_notify_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (25, '支付订单状态', 'pay_order_status', 0, '支付订单状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (26, '退款订单状态', 'pay_refund_status', 0, '退款订单状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (27, '转账订单状态', 'pay_transfer_status', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (28, '商品 SPU 状态', 'product_spu_status', 0, '商品 SPU 状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (29, '促销活动的状态', 'promotion_activity_status', 0, '促销活动的状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (30, 'Banner 位置', 'promotion_banner_position', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (31, '砍价记录的状态', 'promotion_bargain_record_status', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (32, '拼团记录的状态', 'promotion_combination_record_status', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (33, '营销的条件类型', 'promotion_condition_type', 0, '营销的条件类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (34, '优惠劵的状态', 'promotion_coupon_status', 0, '优惠劵的状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (35, '优惠劵的领取方式', 'promotion_coupon_take_type', 0, '优惠劵的领取方式', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (36, '优惠劵模板的有限期类型', 'promotion_coupon_template_validity_type', 0, '优惠劵模板的有限期类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (37, '优惠类型', 'promotion_discount_type', 0, '优惠类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (38, '营销的商品范围', 'promotion_product_scope', 0, '营销的商品范围', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (39, '登陆结果', 'system_login_result', 0, '登陆结果', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (40, '登陆日志的类型', 'system_login_type', 0, '登陆日志的类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (41, '邮件发送状态', 'system_mail_send_status', 0, '邮件发送状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (42, '通知类型', 'system_notice_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (43, '站内信模版的类型', 'system_notify_template_type', 0, '站内信模版的类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (44, 'OAuth 2.0 授权类型', 'system_oauth2_grant_type', 0, 'OAuth 2.0 授权类型（模式）', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (45, '角色类型', 'system_role_type', 0, '角色类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (46, '短信渠道编码', 'system_sms_channel_code', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (47, '短信接收状态', 'system_sms_receive_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (48, '短信发送状态', 'system_sms_send_status', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (49, '短信模板的类型', 'system_sms_template_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (50, '社交类型', 'system_social_type', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (51, '用户性别', 'system_user_sex', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (52, '终端', 'terminal', 0, '终端', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (53, '交易售后状态', 'trade_after_sale_status', 0, '交易售后状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (54, '交易售后的类型', 'trade_after_sale_type', 0, '交易售后的类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (55, '交易售后的方式', 'trade_after_sale_way', 0, '交易售后的方式', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (56, '快递计费方式', 'trade_delivery_express_charge_mode', 0, '用于商城交易模块配送管理', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (57, '交易配送类型', 'trade_delivery_type', 0, '', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (58, '交易订单项的售后状态', 'trade_order_item_after_sale_status', 0, '交易订单项的售后状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (59, '交易订单的状态', 'trade_order_status', 0, '交易订单的状态', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (60, '交易订单的类型', 'trade_order_type', 0, '交易订单的类型', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);
INSERT INTO `ruoyi-vue-pro`.`system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (61, '用户类型', 'user_type', 0, NULL, '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0', NULL);

-- ----------------------------
-- Table structure for system_login_log
-- ----------------------------
DROP TABLE IF EXISTS `system_login_log`;
CREATE TABLE `system_login_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `log_type` bigint NOT NULL COMMENT '日志类型',
  `trace_id` varchar(64) NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户账号',
  `result` tinyint NOT NULL COMMENT '登陆结果',
  `user_ip` varchar(50) NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) NOT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3824 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_mail_account
-- ----------------------------
DROP TABLE IF EXISTS `system_mail_account`;
CREATE TABLE `system_mail_account`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mail` varchar(255) NOT NULL COMMENT '邮箱',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `host` varchar(255) NOT NULL COMMENT 'SMTP 服务器域名',
  `port` int NOT NULL COMMENT 'SMTP 服务器端口',
  `ssl_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 SSL',
  `starttls_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 STARTTLS',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '邮箱账号表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_mail_account
-- ----------------------------

-- ----------------------------
-- Table structure for system_mail_log
-- ----------------------------
DROP TABLE IF EXISTS `system_mail_log`;
CREATE TABLE `system_mail_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint NULL DEFAULT NULL COMMENT '用户类型',
  `to_mail` varchar(255) NOT NULL COMMENT '接收邮箱地址',
  `account_id` bigint NOT NULL COMMENT '邮箱账号编号',
  `from_mail` varchar(255) NOT NULL COMMENT '发送邮箱地址',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(255) NULL DEFAULT NULL COMMENT '模版发送人名称',
  `template_title` varchar(255) NOT NULL COMMENT '邮件标题',
  `template_content` varchar(10240) NOT NULL COMMENT '邮件内容',
  `template_params` varchar(255) NOT NULL COMMENT '邮件参数',
  `send_status` tinyint NOT NULL DEFAULT 0 COMMENT '发送状态',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `send_message_id` varchar(255) NULL DEFAULT NULL COMMENT '发送返回的消息 ID',
  `send_exception` varchar(4096) NULL DEFAULT NULL COMMENT '发送异常',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 360 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '邮件日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_mail_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_mail_template
-- ----------------------------
DROP TABLE IF EXISTS `system_mail_template`;
CREATE TABLE `system_mail_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) NOT NULL COMMENT '模板名称',
  `code` varchar(63) NOT NULL COMMENT '模板编码',
  `account_id` bigint NOT NULL COMMENT '发送的邮箱账号编号',
  `nickname` varchar(255) NULL DEFAULT NULL COMMENT '发送人名称',
  `title` varchar(255) NOT NULL COMMENT '模板标题',
  `content` varchar(10240) NOT NULL COMMENT '模板内容',
  `params` varchar(255) NOT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '邮件模版表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_mail_template
-- ----------------------------

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `permission` varchar(100) NOT NULL DEFAULT '' COMMENT '权限标识',
  `type` tinyint NOT NULL COMMENT '菜单类型',
  `sort` int NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父菜单ID',
  `path` varchar(200) NULL DEFAULT '' COMMENT '路由地址',
  `icon` varchar(100) NULL DEFAULT '#' COMMENT '菜单图标',
  `component` varchar(255) NULL DEFAULT NULL COMMENT '组件路径',
  `component_name` varchar(255) NULL DEFAULT NULL COMMENT '组件名',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '菜单状态',
  `visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可见',
  `keep_alive` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否缓存',
  `always_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否总是显示',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5013 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, 'API 接口', 'infra:swagger:list', 2, 3, 141, 'swagger', 'fa:fighter-jet', 'infra/swagger/index', 'InfraSwagger', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 'API 日志', '', 2, 4, 141, 'log', 'fa:tasks', NULL, NULL, 0, b'1', b'1', b'1', '1', '2021-02-26 02:18:24', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3, 'Banner', '', 2, 100, 88, 'banner', 'fa:bandcamp', 'mall/promotion/banner/index', NULL, 0, b'1', b'1', b'1', '1', '2022-08-01 14:56:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (4, 'Banner创建', 'promotion:banner:create', 3, 2, 3, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-08-01 14:56:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (5, 'Banner删除', 'promotion:banner:delete', 3, 4, 3, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-08-01 14:56:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (6, 'Banner更新', 'promotion:banner:update', 3, 3, 3, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-08-01 14:56:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (7, 'Banner查询', 'promotion:banner:query', 3, 1, 3, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-08-01 14:56:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 'Java 监控', '', 2, 3, 286, 'admin-server', 'ep:coffee-cup', 'infra/server/index', 'InfraAdminServer', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, 'MySQL 监控', '', 2, 1, 286, 'druid', 'fa-solid:box', 'infra/druid/index', 'InfraDruid', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (10, 'OAuth 2.0', '', 2, 10, 367, 'oauth2', 'fa:dashcube', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (11, 'Redis 监控', '', 2, 2, 286, 'redis', 'fa:reddit-square', 'infra/redis/index', 'InfraRedis', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (12, 'WebSocket', '', 2, 5, 141, 'websocket', 'ep:connection', 'infra/webSocket/index', 'InfraWebSocket', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, '三方应用', '', 2, 1, 19, 'client', 'ep:set-up', 'system/social/client/index.vue', 'SocialClient', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, '三方应用创建', 'system:social-client:create', 3, 2, 13, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, '三方应用删除', 'system:social-client:delete', 3, 4, 13, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (16, '三方应用更新', 'system:social-client:update', 3, 3, 13, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (17, '三方应用查询', 'system:social-client:query', 3, 1, 13, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (18, '三方用户', 'system:social-user:query', 2, 2, 19, 'user', 'ep:avatar', 'system/social/user/index.vue', 'SocialUser', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (19, '三方登录', '', 1, 10, 367, 'social', 'fa:rocket', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (20, '主子表（ERP）', '', 2, 11, 30, 'demo03-erp', 'ep:calendar', 'infra/demo/demo03/erp/index', 'Demo03StudentERP', 0, b'1', b'1', b'1', '1', '2023-11-16 15:50:59', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (21, '主子表（内嵌）', '', 2, 12, 30, 'demo03-inner', 'fa:power-off', 'infra/demo/demo03/inner/index', 'Demo03StudentInner', 0, b'1', b'1', b'1', '1', '2023-11-13 04:39:51', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (22, '主子表（标准）', '', 2, 10, 30, 'demo03-normal', 'fa:battery-3', 'infra/demo/demo03/normal/index', 'Demo03StudentNormal', 0, b'1', b'1', b'1', '1', '2023-11-16 12:53:37', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (23, '交易中心配置保存', 'trade:config:save', 3, 2, 28, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (24, '交易中心配置查询', 'trade:config:query', 3, 1, 28, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (25, '交易统计', '', 2, 4, 368, 'trade', 'fa-solid:credit-card', 'mall/statistics/trade/index', 'TradeStatistics', 0, b'1', b'1', b'1', '1', '2023-09-30 03:22:40', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (26, '交易统计导出', 'statistics:trade:export', 3, 2, 25, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-30 03:22:40', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (27, '交易统计查询', 'statistics:trade:query', 3, 1, 25, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-30 03:22:40', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (28, '交易配置', '', 2, 0, 404, 'config', 'ep:setting', 'mall/trade/config/index', 'TradeConfig', 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (29, '代码生成', 'infra:codegen:query', 2, 1, 141, 'codegen', 'ep:document-copy', 'infra/codegen/index', 'InfraCodegen', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (30, '代码生成案例', '', 1, 1, 141, 'demo', 'ep:aim', 'infra/testDemo/index', NULL, 0, b'1', b'1', b'1', '1', '2021-02-06 12:42:49', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (31, '令牌列表', 'system:oauth2-token:page', 3, 1, 33, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (32, '令牌删除', 'system:oauth2-token:delete', 3, 2, 33, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (33, '令牌管理', '', 2, 2, 10, 'token', 'fa:key', 'system/oauth2/token/index', 'SystemTokenClient', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (34, '任务修改', 'infra:job:update', 3, 3, 153, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (35, '任务删除', 'infra:job:delete', 3, 4, 153, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (36, '任务导出', 'infra:job:export', 3, 7, 153, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (37, '任务新增', 'infra:job:create', 3, 2, 153, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (38, '任务查询', 'infra:job:query', 3, 1, 153, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (39, '任务触发', 'infra:job:trigger', 3, 8, 153, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-02-07 13:03:10', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (40, '优惠劵', '', 1, 2, 381, 'coupon', 'fa-solid:disease', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, '优惠劵列表', '', 2, 1, 40, 'template', 'ep:discount', 'mall/promotion/coupon/template/index', 'PromotionCouponTemplate', 0, b'1', b'1', b'1', '1', '2022-10-31 22:27:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, '优惠劵删除', 'promotion:coupon:delete', 3, 4, 461, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-03 23:21:31', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (43, '优惠劵发送', 'promotion:coupon:send', 3, 2, 461, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (44, '优惠劵查询', 'promotion:coupon:query', 3, 1, 461, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-03 23:21:31', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (45, '优惠劵模板创建', 'promotion:coupon-template:create', 3, 2, 41, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-10-31 22:27:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (46, '优惠劵模板删除', 'promotion:coupon-template:delete', 3, 4, 41, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-10-31 22:27:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (47, '优惠劵模板更新', 'promotion:coupon-template:update', 3, 3, 41, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-10-31 22:27:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (48, '优惠劵模板查询', 'promotion:coupon-template:query', 3, 1, 41, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-10-31 22:27:14', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (49, '优惠活动', '', 1, 99, 381, 'youhui', 'ep:aim', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (50, '会员中心', '', 1, 55, 0, '/member', 'ep:bicycle', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (51, '会员分组', '', 2, 3, 50, 'group', 'fa:group', 'member/group/index', 'MemberGroup', 0, b'1', b'1', b'1', '1', '2023-08-22 13:50:06', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (52, '会员标签', '', 2, 1, 50, 'tag', 'ep:collection-tag', 'member/tag/index', 'MemberTag', 0, b'1', b'1', b'1', '1', '2023-08-20 01:03:08', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (53, '会员标签创建', 'member:tag:create', 3, 2, 52, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-20 01:03:08', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (54, '会员标签删除', 'member:tag:delete', 3, 4, 52, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-20 01:03:08', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (55, '会员标签更新', 'member:tag:update', 3, 3, 52, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-20 01:03:08', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (56, '会员标签查询', 'member:tag:query', 3, 1, 52, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-20 01:03:08', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (57, '会员用户更新', 'member:user:update', 3, 3, 67, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-19 04:12:15', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (58, '会员用户查询', 'member:user:query', 3, 1, 67, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-19 04:12:15', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (59, '会员积分', '', 2, 10, 50, 'record', 'fa:asterisk', 'member/point/record/index', 'PointRecord', 0, b'1', b'1', b'1', '1', '2023-06-10 04:18:50', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (60, '会员等级', '', 2, 2, 50, 'level', 'fa:level-up', 'member/level/index', 'MemberLevel', 0, b'1', b'1', b'1', '1', '2023-08-22 12:41:01', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (61, '会员等级创建', 'member:level:create', 3, 2, 60, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 12:41:02', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (62, '会员等级删除', 'member:level:delete', 3, 4, 60, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 12:41:02', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (63, '会员等级更新', 'member:level:update', 3, 3, 60, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 12:41:02', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (64, '会员等级查询', 'member:level:query', 3, 1, 60, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 12:41:02', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (65, '会员等级记录查询', 'member:level-record:query', 3, 10, 60, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (66, '会员签到', '', 1, 11, 50, 'signin', 'ep:alarm-clock', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (67, '会员管理', '', 2, 0, 50, 'user', 'ep:avatar', 'member/user/index', 'MemberUser', 0, b'1', b'1', b'1', '1', '2023-08-19 04:12:15', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (68, '会员经验记录查询', 'member:experience-record:query', 3, 11, 60, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (69, '会员统计', '', 2, 2, 368, 'member', 'ep:avatar', 'mall/statistics/member/index', 'MemberStatistics', 0, b'1', b'1', b'1', '1', '2023-10-11 04:39:24', '1', '2025-06-22 01:27:40', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (70, '会员统计查询', 'statistics:member:query', 3, 1, 69, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-11 04:39:24', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (71, '会员配置', '', 2, 0, 50, 'config', 'fa:archive', 'member/config/index', 'MemberConfig', 0, b'1', b'1', b'1', '1', '2023-06-10 02:07:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (72, '会员配置保存', 'member:config:save', 3, 2, 71, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-06-10 02:07:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (73, '会员配置查询', 'member:config:query', 3, 1, 71, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-06-10 02:07:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (74, '会话删除', 'promotion:kefu-conversation:delete', 3, 3, 159, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (75, '会话更新', 'promotion:kefu-conversation:update', 3, 2, 159, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (76, '会话查询', 'promotion:kefu-conversation:query', 3, 1, 159, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (77, '佣金提现', '', 2, 2, 102, 'brokerage-withdraw', 'fa:credit-card', 'mall/trade/brokerage/withdraw/index', 'TradeBrokerageWithdraw', 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (78, '佣金提现审核', 'trade:brokerage-withdraw:audit', 3, 2, 77, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (79, '佣金提现查询', 'trade:brokerage-withdraw:query', 3, 1, 77, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (80, '佣金记录', '', 2, 1, 102, 'brokerage-record', 'fa:money', 'mall/trade/brokerage/record/index', 'TradeBrokerageRecord', 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (81, '佣金记录查询', 'trade:brokerage-record:query', 3, 1, 80, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (82, '修改推广员', 'trade:brokerage-user:update-bind-user', 3, 5, 97, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (83, '充值套餐', '', 2, 2, 449, 'wallet-recharge-package', 'fa:leaf', 'pay/wallet/rechargePackage/index', 'WalletRechargePackage', 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (84, '公告修改', 'system:notice:update', 3, 3, 425, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (85, '公告删除', 'system:notice:delete', 3, 4, 425, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (86, '公告新增', 'system:notice:create', 3, 2, 425, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (87, '公告查询', 'system:notice:query', 3, 1, 425, '#', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (88, '内容管理', '', 1, 1, 381, 'content', 'ep:collection', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (89, '分类创建', 'promotion:article-category:create', 3, 2, 228, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (90, '分类创建', 'product:category:create', 3, 2, 120, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-29 15:53:53', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (91, '分类删除', 'product:category:delete', 3, 4, 120, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-29 15:53:53', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (92, '分类删除', 'promotion:article-category:delete', 3, 4, 228, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (93, '分类更新', 'promotion:article-category:update', 3, 3, 228, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (94, '分类更新', 'product:category:update', 3, 3, 120, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-29 15:53:53', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (95, '分类查询', 'product:category:query', 3, 1, 120, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-29 15:53:53', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (96, '分类查询', 'promotion:article-category:query', 3, 1, 228, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (97, '分销用户', '', 2, 0, 102, 'brokerage-user', 'fa-solid:user-tie', 'mall/trade/brokerage/user/index', 'TradeBrokerageUser', 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (98, '分销用户修改推广资格', 'trade:brokerage-user:update-brokerage-enable', 3, 4, 97, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (99, '分销用户推广人查询', 'trade:brokerage-user:user-query', 3, 2, 97, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (100, '分销用户推广订单查询', 'trade:brokerage-user:order-query', 3, 3, 97, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (101, '分销用户查询', 'trade:brokerage-user:query', 3, 1, 97, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (102, '分销管理', '', 1, 4, 404, 'brokerage', 'fa-solid:project-diagram', '', '', 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (103, '创建推广员', 'trade:brokerage-user:create', 3, 7, 97, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (104, '助力记录查询', 'promotion:bargain-help:query', 3, 2, 309, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (105, '单表（增删改查）', '', 2, 1, 30, 'demo01-contact', 'ep:bicycle', 'infra/demo/demo01/index', 'Demo01Contact', 0, b'1', b'1', b'1', '1', '2023-11-15 14:42:30', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (106, '发送测试短信', 'system:sms-template:send-sms', 3, 6, 290, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (107, '发送测试站内信', 'system:notify-template:send-notify', 3, 5, 245, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (108, '发送测试邮件', 'system:mail-template:send-mail', 3, 5, 426, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (109, '品牌创建', 'product:brand:create', 3, 2, 124, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 13:52:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (110, '品牌删除', 'product:brand:delete', 3, 4, 124, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 13:52:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (111, '品牌更新', 'product:brand:update', 3, 3, 124, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 13:52:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (112, '品牌查询', 'product:brand:query', 3, 1, 124, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 13:52:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (113, '售后不同意', 'trade:after-sale:disagree', 3, 3, 118, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (114, '售后同意', 'trade:after-sale:agree', 3, 2, 118, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (115, '售后查询', 'trade:after-sale:query', 3, 1, 118, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-19 20:15:33', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (116, '售后确认退款', 'trade:after-sale:refund', 3, 5, 118, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (117, '售后确认退货', 'trade:after-sale:receive', 3, 4, 118, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (118, '售后退款', '', 2, 2, 404, 'after-sale', 'ep:refrigerator', 'mall/trade/afterSale/index', 'TradeAfterSale', 0, b'1', b'1', b'1', '1', '2022-11-19 20:15:32', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (119, '商品中心', '', 1, 60, 135, 'product', 'fa:product-hunt', NULL, NULL, 0, b'1', b'1', b'1', '1', '2022-07-29 15:53:53', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (120, '商品分类', '', 2, 2, 119, 'category', 'ep:cellphone', 'mall/product/category/index', 'ProductCategory', 0, b'1', b'1', b'1', '1', '2022-07-29 15:53:53', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (121, '商品列表', '', 2, 1, 119, 'spu', 'ep:apple', 'mall/product/spu/index', 'ProductSpu', 0, b'1', b'1', b'1', '1', '2022-07-30 14:22:58', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (122, '商品创建', 'product:spu:create', 3, 2, 121, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 14:22:58', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (123, '商品删除', 'product:spu:delete', 3, 4, 121, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 14:22:58', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (124, '商品品牌', '', 2, 3, 119, 'brand', 'ep:chicken', 'mall/product/brand/index', 'ProductBrand', 0, b'1', b'1', b'1', '1', '2022-07-30 13:52:44', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (125, '商品导出', 'product:spu:export', 3, 5, 121, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 14:22:58', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (126, '商品属性', '', 2, 4, 119, 'property', 'ep:cold-drink', 'mall/product/property/index', 'ProductProperty', 0, b'1', b'1', b'1', '1', '2022-08-01 14:55:35', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (127, '商品收藏查询', 'product:favorite:query', 3, 10, 121, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (128, '商品更新', 'product:spu:update', 3, 3, 121, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 14:22:58', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (129, '商品查询', 'product:spu:query', 3, 1, 121, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-07-30 14:22:58', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (130, '商品浏览查询', 'product:browse-history:query', 3, 20, 121, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (131, '商品统计', '', 2, 3, 368, 'product', 'fa:product-hunt', 'mall/statistics/product/index', 'ProductStatistics', 0, b'1', b'1', b'1', '1', '2023-12-15 18:54:28', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (132, '商品统计导出', 'statistics:product:export', 3, 2, 131, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (133, '商品统计查询', 'statistics:product:query', 3, 1, 131, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (134, '商品评论', '', 2, 5, 119, 'comment', 'ep:comment', 'mall/product/comment/index', 'ProductComment', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (135, '商城系统', '', 1, 59, 0, '/mall', 'ep:shop', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (136, '商城装修', '', 2, 20, 381, 'diy-template', 'fa6-solid:brush', 'mall/promotion/diy/template/index', '', 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (137, '商城首页', '', 2, 1, 135, 'home', 'ep:home-filled', 'mall/home/index', 'MallHome', 0, b'1', b'1', b'1', '1', '2023-10-16 12:10:33', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (138, '商家回复', 'product:comment:update', 3, 3, 134, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (139, '回调通知', '', 2, 5, 207, 'notify', 'ep:mute-notification', 'pay/notify/index', 'PayNotify', 0, b'1', b'1', b'1', '1', '2023-07-20 04:41:32', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (140, '地区管理', '', 2, 14, 367, 'area', 'fa:map-marker', 'system/area/index', 'SystemArea', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (141, '基础设施', '', 1, 20, 0, '/infra', 'ep:monitor', NULL, NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (142, '字典修改', 'system:dict:update', 3, 3, 147, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (143, '字典删除', 'system:dict:delete', 3, 4, 147, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (144, '字典导出', 'system:dict:export', 3, 5, 147, '#', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (145, '字典新增', 'system:dict:create', 3, 2, 147, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (146, '字典查询', 'system:dict:query', 3, 1, 147, '#', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (147, '字典管理', '', 2, 6, 367, 'dict', 'ep:collection', 'system/dict/index', 'SystemDictType', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (148, '学生创建', 'infra:demo03-student:create', 3, 2, 22, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:53:37', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (149, '学生删除', 'infra:demo03-student:delete', 3, 4, 22, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:53:37', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (150, '学生导出', 'infra:demo03-student:export', 3, 5, 22, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:53:37', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (151, '学生更新', 'infra:demo03-student:update', 3, 3, 22, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:53:37', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (152, '学生查询', 'infra:demo03-student:query', 3, 1, 22, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:53:37', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (153, '定时任务', '', 2, 7, 141, 'job', 'fa-solid:tasks', 'infra/job/index', 'InfraJob', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (154, '审计日志', '', 1, 9, 367, 'log', 'ep:document-copy', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (155, '客户端创建', 'system:oauth2-client:create', 3, 2, 168, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-05-10 16:26:33', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (156, '客户端删除', 'system:oauth2-client:delete', 3, 4, 168, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-05-10 16:26:33', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (157, '客户端更新', 'system:oauth2-client:update', 3, 3, 168, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-05-10 16:26:33', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (158, '客户端查询', 'system:oauth2-client:query', 3, 1, 168, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-05-10 16:26:33', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (159, '客服中心', '', 2, 100, 135, 'kefu', 'fa-solid:user-alt', 'mall/promotion/kefu/index', 'KeFu', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (160, '导入代码', 'infra:codegen:create', 3, 2, 29, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (161, '岗位修改', 'system:post:update', 3, 3, 166, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (162, '岗位删除', 'system:post:delete', 3, 4, 166, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (163, '岗位导出', 'system:post:export', 3, 5, 166, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:41', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (164, '岗位新增', 'system:post:create', 3, 2, 166, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (165, '岗位查询', 'system:post:query', 3, 1, 166, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (166, '岗位管理', '', 2, 5, 367, 'post', 'fa:address-book-o', 'system/post/index', 'SystemPost', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (167, '应用信息', '', 2, 1, 207, 'app', 'fa:apple', 'pay/app/index', 'PayApp', 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:30', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (168, '应用管理', '', 2, 0, 10, 'oauth2/application', 'fa:hdd-o', 'system/oauth2/client/index', 'SystemOAuth2Client', 0, b'1', b'1', b'1', '1', '2022-05-10 16:26:33', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (169, '快递公司', '', 2, 0, 175, 'express', 'ep:compass', 'mall/trade/delivery/express/index', 'Express', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (170, '快递公司创建', 'trade:delivery:express:create', 3, 2, 169, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-18 09:37:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (171, '快递公司删除', 'trade:delivery:express:delete', 3, 4, 169, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-18 09:37:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (172, '快递公司导出', 'trade:delivery:express:export', 3, 5, 169, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-18 09:37:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (173, '快递公司更新', 'trade:delivery:express:update', 3, 3, 169, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-18 09:37:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (174, '快递公司查询', 'trade:delivery:express:query', 3, 1, 169, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-18 09:37:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (175, '快递发货', '', 1, 0, 441, 'express', 'ep:bicycle', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (176, '快递运费模板创建', 'trade:delivery:express-template:create', 3, 2, 421, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-20 06:49:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (177, '快递运费模板删除', 'trade:delivery:express-template:delete', 3, 4, 421, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-20 06:49:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (178, '快递运费模板导出', 'trade:delivery:express-template:export', 3, 5, 421, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-20 06:49:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (179, '快递运费模板更新', 'trade:delivery:express-template:update', 3, 3, 421, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-20 06:49:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (180, '快递运费模板查询', 'trade:delivery:express-template:query', 3, 1, 421, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-20 06:49:53', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (181, '拼团商品', '', 2, 1, 182, 'acitivity', 'ep:apple', 'mall/promotion/combination/activity/index', 'PromotionCombinationActivity', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (182, '拼团活动', '', 2, 3, 381, 'combination', 'fa:group', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (183, '拼团活动关闭', 'promotion:combination-activity:close', 3, 5, 181, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (184, '拼团活动创建', 'promotion:combination-activity:create', 3, 2, 181, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (185, '拼团活动删除', 'promotion:combination-activity:delete', 3, 4, 181, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (186, '拼团活动更新', 'promotion:combination-activity:update', 3, 3, 181, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (187, '拼团活动查询', 'promotion:combination-activity:query', 3, 1, 181, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (188, '拼团记录', 'promotion:combination-record:query', 2, 2, 182, 'record', 'ep:avatar', 'mall/promotion/combination/record/index.vue', 'PromotionCombinationRecord', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (189, '接入示例', '', 1, 99, 207, 'demo', 'fa-solid:dragon', 'pay/demo/index', NULL, 0, b'1', b'1', b'1', '1', '2023-02-11 14:21:42', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (190, '提现转账案例', '', 2, 2, 189, 'transfer', 'fa:transgender-alt', 'pay/demo/withdraw/index', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (191, '操作日志', '', 2, 1, 154, 'operate-log', 'ep:position', 'system/operatelog/index', 'SystemOperateLog', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (192, '操作查询', 'system:operate-log:query', 3, 1, 191, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (193, '支付&退款案例', '', 2, 1, 189, 'order', 'fa:paypal', 'pay/demo/order/index', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (194, '支付商户信息创建', 'pay:merchant:create', 3, 2, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:41', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (195, '支付商户信息删除', 'pay:merchant:delete', 3, 4, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:41', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (196, '支付商户信息导出', 'pay:merchant:export', 3, 5, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:41', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (197, '支付商户信息更新', 'pay:merchant:update', 3, 3, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:41', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (198, '支付商户信息查询', 'pay:merchant:query', 3, 1, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:41', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (199, '支付应用信息创建', 'pay:app:create', 3, 2, 167, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (200, '支付应用信息删除', 'pay:app:delete', 3, 4, 167, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (201, '支付应用信息更新', 'pay:app:update', 3, 3, 167, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (202, '支付应用信息查询', 'pay:app:query', 3, 1, 167, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-11-10 01:13:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (203, '支付渠道创建', 'pay:channel:create', 3, 11, 167, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (204, '支付渠道删除', 'pay:channel:delete', 3, 13, 167, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (205, '支付渠道更新', 'pay:channel:update', 3, 12, 167, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (206, '支付渠道查询', 'pay:channel:query', 3, 10, 167, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (207, '支付管理', '', 1, 30, 0, '/pay', 'ep:money', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (208, '支付订单', '', 2, 2, 207, 'order', 'fa:cc-paypal', 'pay/order/index', 'PayOrder', 0, b'1', b'1', b'1', '1', '2021-12-25 08:49:43', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (209, '支付订单导出', 'pay:order:export', 3, 5, 208, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-25 08:49:43', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (210, '支付订单查询', 'pay:order:query', 3, 1, 208, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-25 08:49:43', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (211, '支付通知查询', 'pay:notify:query', 3, 1, 139, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-07-20 04:41:32', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (212, '数据源配置', '', 2, 1, 141, 'data-source-config', 'ep:data-analysis', 'infra/dataSourceConfig/index', 'InfraDataSourceConfig', 0, b'1', b'1', b'1', '1', '2022-04-27 14:37:32', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (213, '数据源配置创建', 'infra:data-source-config:create', 3, 2, 212, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-04-27 14:37:32', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (214, '数据源配置删除', 'infra:data-source-config:delete', 3, 4, 212, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-04-27 14:37:32', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (215, '数据源配置导出', 'infra:data-source-config:export', 3, 5, 212, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-04-27 14:37:32', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (216, '数据源配置更新', 'infra:data-source-config:update', 3, 3, 212, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-04-27 14:37:32', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (217, '数据源配置查询', 'infra:data-source-config:query', 3, 1, 212, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-04-27 14:37:32', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (218, '文件列表', '', 2, 5, 221, 'file', 'ep:upload-filled', 'infra/file/index', 'InfraFile', 0, b'1', b'1', b'1', '1', '2021-03-12 20:16:20', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (219, '文件删除', 'infra:file:delete', 3, 4, 218, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-03-12 20:16:20', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (220, '文件查询', 'infra:file:query', 3, 1, 218, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-03-12 20:16:20', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (221, '文件管理', '', 2, 6, 141, 'file', 'ep:files', NULL, '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (222, '文件配置', '', 2, 0, 221, 'file-config', 'fa-solid:file-signature', 'infra/fileConfig/index', 'InfraFileConfig', 0, b'1', b'1', b'1', '1', '2022-03-15 14:35:28', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (223, '文件配置创建', 'infra:file-config:create', 3, 2, 222, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-03-15 14:35:28', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (224, '文件配置删除', 'infra:file-config:delete', 3, 4, 222, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-03-15 14:35:28', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (225, '文件配置导出', 'infra:file-config:export', 3, 5, 222, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-03-15 14:35:28', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (226, '文件配置更新', 'infra:file-config:update', 3, 3, 222, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-03-15 14:35:28', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (227, '文件配置查询', 'infra:file-config:query', 3, 1, 222, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-03-15 14:35:28', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (228, '文章分类', '', 2, 0, 88, 'article/category', 'fa:certificate', 'mall/promotion/article/category/index', 'ArticleCategory', 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (229, '文章列表', '', 2, 2, 88, 'article', 'ep:connection', 'mall/promotion/article/index', 'Article', 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (230, '文章管理创建', 'promotion:article:create', 3, 2, 229, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (231, '文章管理删除', 'promotion:article:delete', 3, 4, 229, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (232, '文章管理更新', 'promotion:article:update', 3, 3, 229, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (233, '文章管理查询', 'promotion:article:query', 3, 1, 229, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-16 01:26:18', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (234, '日志处理', 'infra:api-error-log:update-status', 3, 2, 451, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-02-26 07:53:20', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (235, '日志导出', 'system:operate-log:export', 3, 2, 191, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (236, '日志导出', 'system:login-log:export', 3, 3, 284, '#', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (237, '日志导出', 'infra:api-access-log:export', 3, 2, 412, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-02-26 01:32:59', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (238, '日志导出', 'infra:api-error-log:export', 3, 3, 451, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-02-26 07:53:20', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (239, '日志查询', 'infra:api-access-log:query', 3, 1, 412, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (240, '日志查询', 'infra:api-error-log:query', 3, 1, 451, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (241, '日志查询', 'system:mail-log:query', 3, 1, 427, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-26 02:16:50', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (242, '显隐评论', 'product:comment:update', 3, 4, 134, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (243, '树表（增删改查）', '', 2, 2, 30, 'demo02-category', 'fa:tree', 'infra/demo/demo02/index', 'Demo02Category', 0, b'1', b'1', b'1', '1', '2023-11-16 12:18:27', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (244, '核销订单', '', 2, 2, 453, 'pick-up-order', 'ep:list', 'mall/trade/delivery/pickUpOrder/index', 'PickUpOrder', 0, b'1', b'1', b'1', '1', '2023-10-19 16:09:51', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (245, '模板管理', '', 2, 0, 364, 'notify-template', 'fa:archive', 'system/notify/template/index', 'SystemNotifyTemplate', 0, b'1', b'1', b'1', '1', '2023-01-28 02:26:42', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (246, '模版创建', 'system:mail-template:create', 3, 2, 426, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 12:05:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (247, '模版删除', 'system:mail-template:delete', 3, 4, 426, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 12:05:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (248, '模版更新', 'system:mail-template:update', 3, 3, 426, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 12:05:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (249, '模版查询', 'system:mail-template:query', 3, 1, 426, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 12:05:31', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (250, '消息中心', '', 1, 7, 367, 'messages', 'ep:chat-dot-round', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (251, '消息发送', 'promotion:kefu-message:send', 3, 12, 159, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (252, '消息更新', 'promotion:kefu-message:update', 3, 11, 159, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (253, '消息查询', 'promotion:kefu-message:query', 3, 10, 159, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (254, '消息记录', '', 2, 0, 364, 'notify-message', 'fa:edit', 'system/notify/message/index', 'SystemNotifyMessage', 0, b'1', b'1', b'1', '1', '2023-01-28 04:28:22', '1', '2025-06-22 01:27:42', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (255, '添加自评', 'product:comment:create', 3, 2, 134, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (256, '清除推广员', 'trade:brokerage-user:clear-bind-user', 3, 6, 97, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-09-28 02:46:22', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (257, '满减送', '', 2, 10, 49, 'reward-activity', 'ep:goblet-square-full', 'mall/promotion/rewardActivity/index', 'PromotionRewardActivity', 0, b'1', b'1', b'1', '1', '2022-11-04 23:47:49', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (258, '满减送活动关闭', 'promotion:reward-activity:close', 3, 5, 257, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (259, '满减送活动创建', 'promotion:reward-activity:create', 3, 2, 257, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-04 23:47:49', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (260, '满减送活动删除', 'promotion:reward-activity:delete', 3, 4, 257, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-04 23:47:50', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (261, '满减送活动更新', 'promotion:reward-activity:update', 3, 3, 257, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-04 23:47:50', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (262, '满减送活动查询', 'promotion:reward-activity:query', 3, 1, 257, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-04 23:47:49', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (263, '状态修改', 'infra:job:update', 3, 5, 153, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (264, '生成代码', 'infra:codegen:download', 3, 5, 29, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (265, '生成修改', 'infra:codegen:update', 3, 2, 29, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (266, '生成删除', 'infra:codegen:delete', 3, 3, 29, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (267, '用户余额修改', 'pay:wallet:update-balance', 3, 7, 67, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-10-01 14:39:43', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (268, '用户修改', 'system:user:update', 3, 3, 283, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (269, '用户分组创建', 'member:group:create', 3, 2, 51, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 13:50:06', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (270, '用户分组删除', 'member:group:delete', 3, 4, 51, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 13:50:06', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (271, '用户分组更新', 'member:group:update', 3, 3, 51, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 13:50:06', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (272, '用户分组查询', 'member:group:query', 3, 1, 51, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-22 13:50:06', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (273, '用户删除', 'system:user:delete', 3, 4, 283, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (274, '用户导入', 'system:user:import', 3, 6, 283, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (275, '用户导出', 'system:user:export', 3, 5, 283, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (276, '用户新增', 'system:user:create', 3, 2, 283, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (277, '用户查询', 'system:user:query', 3, 1, 283, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (278, '用户积分修改', 'member:user:update-point', 3, 6, 67, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-01 14:39:43', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (279, '用户积分记录查询', 'point:record:query', 3, 1, 59, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-06-10 04:18:50', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (280, '用户等级修改', 'member:user:update-level', 3, 5, 67, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-08-23 16:49:05', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (281, '用户签到积分删除', 'point:sign-in-record:delete', 3, 4, 365, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-06-10 04:48:22', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (282, '用户签到积分查询', 'point:sign-in-record:query', 3, 1, 365, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-06-10 04:48:22', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (283, '用户管理', 'system:user:list', 2, 1, 367, 'user', 'ep:avatar', 'system/user/index', 'SystemUser', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (284, '登录日志', '', 2, 2, 154, 'login-log', 'ep:promotion', 'system/loginlog/index', 'SystemLoginLog', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (285, '登录查询', 'system:login-log:query', 3, 1, 284, '#', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (286, '监控中心', '', 1, 10, 141, 'monitors', 'ep:monitor', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (287, '短信日志', '', 2, 2, 301, 'sms-log', 'fa:edit', 'system/sms/log/index', 'SystemSmsLog', 0, b'1', b'1', b'1', '1', '2021-04-11 08:37:05', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (288, '短信日志导出', 'system:sms-log:export', 3, 5, 287, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-11 08:37:05', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (289, '短信日志查询', 'system:sms-log:query', 3, 1, 287, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-11 08:37:05', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (290, '短信模板', '', 2, 1, 301, 'sms-template', 'ep:connection', 'system/sms/template/index', 'SystemSmsTemplate', 0, b'1', b'1', b'1', '1', '2021-04-01 17:35:17', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (291, '短信模板创建', 'system:sms-template:create', 3, 2, 290, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 17:35:17', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (292, '短信模板删除', 'system:sms-template:delete', 3, 4, 290, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 17:35:17', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (293, '短信模板导出', 'system:sms-template:export', 3, 5, 290, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 17:35:17', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (294, '短信模板更新', 'system:sms-template:update', 3, 3, 290, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 17:35:17', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (295, '短信模板查询', 'system:sms-template:query', 3, 1, 290, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 17:35:17', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (296, '短信渠道', '', 2, 0, 301, 'sms-channel', 'fa:stack-exchange', 'system/sms/channel/index', 'SystemSmsChannel', 0, b'1', b'1', b'1', '1', '2021-04-01 11:07:15', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (297, '短信渠道创建', 'system:sms-channel:create', 3, 2, 296, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 11:07:15', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (298, '短信渠道删除', 'system:sms-channel:delete', 3, 4, 296, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 11:07:15', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (299, '短信渠道更新', 'system:sms-channel:update', 3, 3, 296, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 11:07:15', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (300, '短信渠道查询', 'system:sms-channel:query', 3, 1, 296, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-01 11:07:15', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (301, '短信管理', '', 1, 1, 250, 'sms', 'ep:message', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (302, '砍价商品', '', 2, 1, 303, 'activity', 'ep:burger', 'mall/promotion/bargain/activity/index', 'PromotionBargainActivity', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (303, '砍价活动', '', 2, 4, 381, 'bargain', 'ep:box', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (304, '砍价活动关闭', 'promotion:bargain-activity:close', 3, 5, 302, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (305, '砍价活动创建', 'promotion:bargain-activity:create', 3, 2, 302, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (306, '砍价活动删除', 'promotion:bargain-activity:delete', 3, 4, 302, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (307, '砍价活动更新', 'promotion:bargain-activity:update', 3, 3, 302, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (308, '砍价活动查询', 'promotion:bargain-activity:query', 3, 1, 302, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (309, '砍价记录', '', 2, 2, 303, 'record', 'ep:list', 'mall/promotion/bargain/record/index', 'PromotionBargainRecord', 0, b'1', b'1', b'1', '1', '2023-10-05 02:49:06', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (310, '砍价记录查询', 'promotion:bargain-record:query', 3, 1, 309, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-05 02:49:06', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (311, '示例分类创建', 'infra:demo02-category:create', 3, 2, 243, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:18:27', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (312, '示例分类删除', 'infra:demo02-category:delete', 3, 4, 243, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:18:27', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (313, '示例分类导出', 'infra:demo02-category:export', 3, 5, 243, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:18:27', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (314, '示例分类更新', 'infra:demo02-category:update', 3, 3, 243, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:18:27', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (315, '示例分类查询', 'infra:demo02-category:query', 3, 1, 243, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-16 12:18:27', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (316, '示例联系人创建', 'infra:demo01-contact:create', 3, 2, 105, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-15 14:42:30', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (317, '示例联系人删除', 'infra:demo01-contact:delete', 3, 4, 105, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-15 14:42:30', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (318, '示例联系人导出', 'infra:demo01-contact:export', 3, 5, 105, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-15 14:42:30', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (319, '示例联系人更新', 'infra:demo01-contact:update', 3, 3, 105, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-15 14:42:30', '1', '2025-06-22 01:27:43', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (320, '示例联系人查询', 'infra:demo01-contact:query', 3, 1, 105, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-11-15 14:42:30', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (321, '秒杀商品', '', 2, 2, 327, 'activity', 'ep:basketball', 'mall/promotion/seckill/activity/index', 'PromotionSeckillActivity', 0, b'1', b'1', b'1', '1', '2022-11-06 22:24:49', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (322, '秒杀时段', '', 2, 1, 327, 'config', 'ep:baseball', 'mall/promotion/seckill/config/index', 'PromotionSeckillConfig', 0, b'1', b'1', b'1', '1', '2022-11-15 19:46:50', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (323, '秒杀时段创建', 'promotion:seckill-config:create', 3, 2, 322, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-11-15 19:46:51', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (324, '秒杀时段删除', 'promotion:seckill-config:delete', 3, 4, 322, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-11-15 19:46:51', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (325, '秒杀时段更新', 'promotion:seckill-config:update', 3, 3, 322, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-11-15 19:46:51', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (326, '秒杀时段查询', 'promotion:seckill-config:query', 3, 1, 322, '', '', '', '', 0, b'1', b'1', b'1', '1', '2022-11-15 19:46:51', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (327, '秒杀活动', '', 2, 3, 381, 'seckill', 'ep:place', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (328, '秒杀活动关闭', 'promotion:seckill-activity:close', 3, 5, 321, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (329, '秒杀活动创建', 'promotion:seckill-activity:create', 3, 2, 321, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-06 22:24:49', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (330, '秒杀活动删除', 'promotion:seckill-activity:delete', 3, 4, 321, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-06 22:24:49', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (331, '秒杀活动更新', 'promotion:seckill-activity:update', 3, 3, 321, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-06 22:24:49', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (332, '秒杀活动查询', 'promotion:seckill-activity:query', 3, 1, 321, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-06 22:24:49', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (333, '秘钥解析', 'pay:channel:parsing', 3, 6, 201, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (334, '秘钥解析', '', 3, 6, 201, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (335, '租户切换', 'system:tenant:visit', 3, 999, 336, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (336, '租户列表', '', 2, 0, 347, 'list', 'ep:house', 'system/tenant/index', 'SystemTenant', 0, b'1', b'1', b'1', '1', '2021-12-14 12:31:43', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (337, '租户创建', 'system:tenant:create', 3, 2, 336, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-14 12:31:44', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (338, '租户删除', 'system:tenant:delete', 3, 4, 336, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-14 12:31:44', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (339, '租户套餐', '', 2, 0, 347, 'package', 'fa:bars', 'system/tenantPackage/index', 'SystemTenantPackage', 0, b'1', b'1', b'1', '1', '2022-02-19 17:44:06', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (340, '租户套餐创建', 'system:tenant-package:create', 3, 2, 339, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-02-19 17:44:06', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (341, '租户套餐删除', 'system:tenant-package:delete', 3, 4, 339, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-02-19 17:44:06', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (342, '租户套餐更新', 'system:tenant-package:update', 3, 3, 339, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-02-19 17:44:06', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (343, '租户套餐查询', 'system:tenant-package:query', 3, 1, 339, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-02-19 17:44:06', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (344, '租户导出', 'system:tenant:export', 3, 5, 336, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-14 12:31:44', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (345, '租户更新', 'system:tenant:update', 3, 3, 336, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-14 12:31:44', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (346, '租户查询', 'system:tenant:query', 3, 1, 336, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-14 12:31:44', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (347, '租户管理', '', 2, 0, 367, 'tenant', 'fa-solid:house-user', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (348, '积分商城', '', 2, 5, 381, 'point-activity', 'ep:bowl', 'mall/promotion/point/activity/index', 'PointActivity', 0, b'1', b'1', b'1', '1', '2024-09-21 05:36:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (349, '积分商城活动关闭', 'promotion:point-activity:close', 3, 6, 348, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (350, '积分商城活动创建', 'promotion:point-activity:create', 3, 2, 348, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-09-21 05:36:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (351, '积分商城活动删除', 'promotion:point-activity:delete', 3, 4, 348, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-09-21 05:36:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (352, '积分商城活动导出', 'promotion:point-activity:export', 3, 5, 348, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-09-21 05:36:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (353, '积分商城活动更新', 'promotion:point-activity:update', 3, 3, 348, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-09-21 05:36:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (354, '积分商城活动查询', 'promotion:point-activity:query', 3, 1, 348, '', '', '', '', 0, b'1', b'1', b'1', '1', '2024-09-21 05:36:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (355, '积分签到规则创建', 'point:sign-in-config:create', 3, 2, 366, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-06-10 03:26:12', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (356, '积分签到规则删除', 'point:sign-in-config:delete', 3, 4, 366, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-06-10 03:26:12', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (357, '积分签到规则更新', 'point:sign-in-config:update', 3, 3, 366, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-06-10 03:26:12', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (358, '积分签到规则查询', 'point:sign-in-config:query', 3, 1, 366, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-06-10 03:26:12', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (359, '站内信模板创建', 'system:notify-template:create', 3, 2, 245, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-28 02:26:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (360, '站内信模板删除', 'system:notify-template:delete', 3, 4, 245, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-28 02:26:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (361, '站内信模板更新', 'system:notify-template:update', 3, 3, 245, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-28 02:26:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (362, '站内信模板查询', 'system:notify-template:query', 3, 1, 245, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-28 02:26:42', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (363, '站内信消息查询', 'system:notify-message:query', 3, 1, 254, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-28 04:28:22', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (364, '站内信管理', '', 1, 3, 250, 'notify', 'ep:message-box', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (365, '签到记录', '', 2, 3, 66, 'record', 'ep:chicken', 'member/signin/record/index', 'SignInRecord', 0, b'1', b'1', b'1', '1', '2023-06-10 04:48:22', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (366, '签到配置', '', 2, 2, 66, 'config', 'ep:calendar', 'member/signin/config/index', 'SignInConfig', 0, b'1', b'1', b'1', '1', '2023-06-10 03:26:12', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (367, '系统管理', '', 1, 10, 0, '/system', 'ep:tools', NULL, NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (368, '统计中心', '', 1, 75, 135, 'statistics', 'ep:data-line', '', '', 0, b'1', b'1', b'1', '1', '2023-09-30 03:22:40', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (369, '自提门店创建', 'trade:delivery:pick-up-store:create', 3, 2, 452, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-25 10:53:29', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (370, '自提门店删除', 'trade:delivery:pick-up-store:delete', 3, 4, 452, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-25 10:53:29', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (371, '自提门店导出', 'trade:delivery:pick-up-store:export', 3, 5, 452, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-25 10:53:29', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (372, '自提门店更新', 'trade:delivery:pick-up-store:update', 3, 3, 452, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-25 10:53:29', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (373, '自提门店查询', 'trade:delivery:pick-up-store:query', 3, 1, 452, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-05-25 10:53:29', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (374, '获得 Redis Key 列表', 'infra:redis:get-key-list', 3, 2, 11, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-26 01:02:52', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (375, '获得 Redis 监控信息', 'infra:redis:get-monitor-info', 3, 1, 11, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-26 01:02:31', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (376, '菜单修改', 'system:menu:update', 3, 3, 380, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (377, '菜单删除', 'system:menu:delete', 3, 4, 380, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (378, '菜单新增', 'system:menu:create', 3, 2, 380, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (379, '菜单查询', 'system:menu:query', 3, 1, 380, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (380, '菜单管理', '', 2, 3, 367, 'menu', 'ep:menu', 'system/menu/index', 'SystemMenu', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (381, '营销中心', '', 1, 70, 135, 'promotion', 'ep:present', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (382, '表单构建', 'infra:build:list', 2, 2, 141, 'build', 'fa:wpforms', 'infra/build/index', 'InfraBuild', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (383, '装修模板', '', 2, 1, 136, 'diy-template', 'fa6-solid:brush', 'mall/promotion/diy/template/index', 'DiyTemplate', 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (384, '装修模板使用', 'promotion:diy-template:use', 3, 5, 383, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (385, '装修模板创建', 'promotion:diy-template:create', 3, 2, 383, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (386, '装修模板删除', 'promotion:diy-template:delete', 3, 4, 383, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (387, '装修模板更新', 'promotion:diy-template:update', 3, 3, 383, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (388, '装修模板查询', 'promotion:diy-template:query', 3, 1, 383, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (389, '装修页面', '', 2, 2, 136, 'diy-page', 'foundation:page-edit', 'mall/promotion/diy/page/index', 'DiyPage', 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (390, '装修页面创建', 'promotion:diy-page:create', 3, 2, 389, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:26', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (391, '装修页面删除', 'promotion:diy-page:delete', 3, 4, 389, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:26', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (392, '装修页面更新', 'promotion:diy-page:update', 3, 3, 389, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:26', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (393, '装修页面查询', 'promotion:diy-page:query', 3, 1, 389, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-10-29 14:19:25', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (394, '规格创建', 'product:property:create', 3, 2, 126, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-08-01 14:55:35', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (395, '规格删除', 'product:property:delete', 3, 4, 126, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-08-01 14:55:35', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (396, '规格更新', 'product:property:update', 3, 3, 126, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-08-01 14:55:35', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (397, '规格查询', 'product:property:query', 3, 1, 126, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-08-01 14:55:35', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (398, '角色修改', 'system:role:update', 3, 3, 403, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (399, '角色删除', 'system:role:delete', 3, 4, 403, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (400, '角色导出', 'system:role:export', 3, 5, 403, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:44', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (401, '角色新增', 'system:role:create', 3, 2, 403, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (402, '角色查询', 'system:role:query', 3, 1, 403, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (403, '角色管理', '', 2, 2, 367, 'role', 'ep:user', 'system/role/index', 'SystemRole', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (404, '订单中心', '', 1, 65, 135, 'trade', 'ep:eleme', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (405, '订单列表', '', 2, 1, 404, 'order', 'ep:list', 'mall/trade/order/index', 'TradeOrder', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (406, '订单更新', 'trade:order:update', 3, 2, 405, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (407, '订单查询', 'trade:order:query', 3, 1, 405, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (408, '订单核销', 'trade:order:pick-up', 3, 10, 405, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (409, '设置用户角色', 'system:permission:assign-user-role', 3, 8, 403, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-07 10:23:28', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (410, '设置角色数据权限', 'system:permission:assign-role-data-scope', 3, 7, 403, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-06 17:56:31', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (411, '设置角色菜单权限', 'system:permission:assign-role-menu', 3, 6, 403, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-06 17:53:44', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (412, '访问日志', '', 2, 1, 2, 'api-access-log', 'ep:place', 'infra/apiAccessLog/index', 'InfraApiAccessLog', 0, b'1', b'1', b'1', '1', '2021-02-26 01:32:59', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (413, '评论查询', 'product:comment:query', 3, 1, 134, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (414, '账号创建', 'system:mail-account:create', 3, 2, 429, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 09:33:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (415, '账号删除', 'system:mail-account:delete', 3, 4, 429, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 09:33:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (416, '账号更新', 'system:mail-account:update', 3, 3, 429, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 09:33:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (417, '账号查询', 'system:mail-account:query', 3, 1, 429, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 09:33:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (418, '转账订单', '', 2, 3, 207, 'transfer', 'ep:credit-card', 'pay/transfer/index', 'PayTransfer', 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (419, '转账订单导出', 'pay:transfer:export', 3, 2, 418, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (420, '转账订单查询', 'pay:transfer:query', 3, 1, 418, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (421, '运费模版', 'trade:delivery:express-template:query', 2, 1, 175, 'express-template', 'ep:coordinate', 'mall/trade/delivery/expressTemplate/index', 'ExpressTemplate', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (422, '退款订单', '', 2, 3, 207, 'refund', 'fa:registered', 'pay/refund/index', 'PayRefund', 0, b'1', b'1', b'1', '1', '2021-12-25 08:29:07', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (423, '退款订单导出', 'pay:refund:export', 3, 5, 422, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-25 08:29:07', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (424, '退款订单查询', 'pay:refund:query', 3, 1, 422, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-12-25 08:29:07', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (425, '通知公告', '', 2, 4, 250, 'notice', 'ep:takeaway-box', 'system/notice/index', 'SystemNotice', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (426, '邮件模版', '', 2, 0, 428, 'mail-template', 'fa:tag', 'system/mail/template/index', 'SystemMailTemplate', 0, b'1', b'1', b'1', '1', '2023-01-25 12:05:31', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (427, '邮件记录', '', 2, 0, 428, 'mail-log', 'fa:edit', 'system/mail/log/index', 'SystemMailLog', 0, b'1', b'1', b'1', '1', '2023-01-26 02:16:50', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (428, '邮箱管理', '', 2, 2, 250, 'mail', 'fa-solid:mail-bulk', NULL, NULL, 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (429, '邮箱账号', '', 2, 0, 428, 'mail-account', 'fa:universal-access', 'system/mail/account/index', 'SystemMailAccount', 0, b'1', b'1', b'1', '1', '2023-01-25 09:33:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (430, '部门修改', 'system:dept:update', 3, 3, 434, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (431, '部门删除', 'system:dept:delete', 3, 4, 434, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (432, '部门新增', 'system:dept:create', 3, 2, 434, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (433, '部门查询', 'system:dept:query', 3, 1, 434, '', '#', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (434, '部门管理', '', 2, 4, 367, 'dept', 'fa:address-card', 'system/dept/index', 'SystemDept', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (435, '配置修改', 'infra:config:update', 3, 3, 440, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (436, '配置删除', 'infra:config:delete', 3, 4, 440, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (437, '配置导出', 'infra:config:export', 3, 5, 440, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (438, '配置新增', 'infra:config:create', 3, 2, 440, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (439, '配置查询', 'infra:config:query', 3, 1, 440, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (440, '配置管理', '', 2, 8, 141, 'config', 'fa:connectdevelop', 'infra/config/index', 'InfraConfig', 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (441, '配送管理', '', 1, 3, 404, 'delivery', 'ep:shopping-cart', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (442, '重置密码', 'system:user:update-password', 3, 7, 283, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (443, '钱包余额', '', 2, 1, 449, 'wallet-balance', 'fa:leaf', 'pay/wallet/balance/index', 'WalletBalance', 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (444, '钱包余额查询', 'pay:wallet:query', 3, 1, 443, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (445, '钱包充值套餐创建', 'pay:wallet-recharge-package:create', 3, 2, 83, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (446, '钱包充值套餐删除', 'pay:wallet-recharge-package:delete', 3, 4, 83, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (447, '钱包充值套餐更新', 'pay:wallet-recharge-package:update', 3, 3, 83, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (448, '钱包充值套餐查询', 'pay:wallet-recharge-package:query', 3, 1, 83, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (449, '钱包管理', '', 1, 4, 207, 'wallet', 'ep:wallet', '', '', 0, b'1', b'1', b'1', '1', '2023-12-29 02:32:54', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (450, '链路追踪', '', 2, 4, 286, 'skywalking', 'fa:eye', 'infra/skywalking/index', 'InfraSkyWalking', 0, b'1', b'1', b'1', '1', '2021-02-08 20:41:31', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (451, '错误日志', 'infra:api-error-log:query', 2, 2, 2, 'api-error-log', 'ep:warning-filled', 'infra/apiErrorLog/index', 'InfraApiErrorLog', 0, b'1', b'1', b'1', '1', '2021-02-26 07:53:20', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (452, '门店管理', '', 2, 1, 453, 'pick-up-store', 'ep:basketball', 'mall/trade/delivery/pickUpStore/index', 'PickUpStore', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (453, '门店自提', '', 1, 1, 441, 'pick-up-store', 'ep:add-location', '', '', 0, b'1', b'1', b'1', '1', '2025-06-22 00:00:00', '1', '2025-06-22 00:00:00', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (454, '限时折扣', '', 2, 7, 49, 'discount-activity', 'ep:timer', 'mall/promotion/discountActivity/index', 'PromotionDiscountActivity', 0, b'1', b'1', b'1', '1', '2022-11-05 17:12:15', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (455, '限时折扣活动关闭', 'promotion:discount-activity:close', 3, 5, 454, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-05 17:12:16', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (456, '限时折扣活动创建', 'promotion:discount-activity:create', 3, 2, 454, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-05 17:12:15', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (457, '限时折扣活动删除', 'promotion:discount-activity:delete', 3, 4, 454, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-05 17:12:16', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (458, '限时折扣活动更新', 'promotion:discount-activity:update', 3, 3, 454, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-05 17:12:16', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (459, '限时折扣活动查询', 'promotion:discount-activity:query', 3, 1, 454, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2022-11-05 17:12:15', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (460, '预览代码', 'infra:codegen:preview', 3, 4, 29, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-01-05 17:03:48', '1', '2025-06-22 01:27:45', b'0');
INSERT INTO `ruoyi-vue-pro`.`system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (461, '领取记录', '', 2, 2, 40, 'list', 'ep:collection-tag', 'mall/promotion/coupon/index', 'PromotionCoupon', 0, b'1', b'1', b'1', '1', '2022-11-03 23:21:31', '1', '2025-06-22 01:27:45', b'0');

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(50) NOT NULL COMMENT '公告标题',
  `content` text NOT NULL COMMENT '公告内容',
  `type` tinyint NOT NULL COMMENT '公告类型（1通知 2公告）',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '公告状态（0正常 1关闭）',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_notice
-- ----------------------------

-- ----------------------------
-- Table structure for system_notify_message
-- ----------------------------
DROP TABLE IF EXISTS `system_notify_message`;
CREATE TABLE `system_notify_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `template_id` bigint NOT NULL COMMENT '模版编号',
  `template_code` varchar(64) NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(63) NOT NULL COMMENT '模版发送人名称',
  `template_content` varchar(1024) NOT NULL COMMENT '模版内容',
  `template_type` int NOT NULL COMMENT '模版类型',
  `template_params` varchar(255) NOT NULL COMMENT '模版参数',
  `read_status` bit(1) NOT NULL COMMENT '是否已读',
  `read_time` datetime NULL DEFAULT NULL COMMENT '阅读时间',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '站内信消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_notify_message
-- ----------------------------

-- ----------------------------
-- Table structure for system_notify_template
-- ----------------------------
DROP TABLE IF EXISTS `system_notify_template`;
CREATE TABLE `system_notify_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(63) NOT NULL COMMENT '模板名称',
  `code` varchar(64) NOT NULL COMMENT '模版编码',
  `nickname` varchar(255) NOT NULL COMMENT '发送人名称',
  `content` varchar(1024) NOT NULL COMMENT '模版内容',
  `type` tinyint NOT NULL COMMENT '类型',
  `params` varchar(255) NULL DEFAULT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '状态',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '站内信模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_notify_template
-- ----------------------------

-- ----------------------------
-- Table structure for system_oauth2_access_token
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_access_token`;
CREATE TABLE `system_oauth2_access_token`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `user_info` varchar(512) NOT NULL COMMENT '用户信息',
  `access_token` varchar(255) NOT NULL COMMENT '访问令牌',
  `refresh_token` varchar(32) NOT NULL COMMENT '刷新令牌',
  `client_id` varchar(255) NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) NULL DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_access_token`(`access_token` ASC) USING BTREE,
  INDEX `idx_refresh_token`(`refresh_token` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16705 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 访问令牌' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_oauth2_access_token
-- ----------------------------

-- ----------------------------
-- Table structure for system_oauth2_approve
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_approve`;
CREATE TABLE `system_oauth2_approve`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) NOT NULL COMMENT '客户端编号',
  `scope` varchar(255) NOT NULL DEFAULT '' COMMENT '授权范围',
  `approved` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否接受',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 批准表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_oauth2_approve
-- ----------------------------

-- ----------------------------
-- Table structure for system_oauth2_client
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_client`;
CREATE TABLE `system_oauth2_client`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `client_id` varchar(255) NOT NULL COMMENT '客户端编号',
  `secret` varchar(255) NOT NULL COMMENT '客户端密钥',
  `name` varchar(255) NOT NULL COMMENT '应用名',
  `logo` varchar(255) NOT NULL COMMENT '应用图标',
  `description` varchar(255) NULL DEFAULT NULL COMMENT '应用描述',
  `status` tinyint NOT NULL COMMENT '状态',
  `access_token_validity_seconds` int NOT NULL COMMENT '访问令牌的有效期',
  `refresh_token_validity_seconds` int NOT NULL COMMENT '刷新令牌的有效期',
  `redirect_uris` varchar(255) NOT NULL COMMENT '可重定向的 URI 地址',
  `authorized_grant_types` varchar(255) NOT NULL COMMENT '授权类型',
  `scopes` varchar(255) NULL DEFAULT NULL COMMENT '授权范围',
  `auto_approve_scopes` varchar(255) NULL DEFAULT NULL COMMENT '自动通过的授权范围',
  `authorities` varchar(255) NULL DEFAULT NULL COMMENT '权限',
  `resource_ids` varchar(255) NULL DEFAULT NULL COMMENT '资源',
  `additional_information` varchar(4096) NULL DEFAULT NULL COMMENT '附加信息',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 客户端表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_oauth2_client
-- ----------------------------
INSERT INTO `system_oauth2_client` VALUES (1, 'default', 'Hs2xyIOsG2Fq2eL0', '安泉到家', 'http://192.168.56.128:9000/mall/20250622/logo_1750558344111.jpg', '安泉到家', 0, 1800, 2592000, '[\"https://www.anquandaojia.cn\"]', '[\"password\",\"authorization_code\",\"implicit\",\"refresh_token\"]', '[\"user.read\",\"user.write\"]', '[]', '[\"user.read\",\"user.write\"]', '[]', '{}', '1', '2025-06-20 00:00:00', '1', '2025-06-20 00:00:00', b'0');

-- ----------------------------
-- Table structure for system_oauth2_code
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_code`;
CREATE TABLE `system_oauth2_code`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `code` varchar(32) NOT NULL COMMENT '授权码',
  `client_id` varchar(255) NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) NULL DEFAULT '' COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `redirect_uri` varchar(255) NULL DEFAULT NULL COMMENT '可重定向的 URI 地址',
  `state` varchar(255) NOT NULL DEFAULT '' COMMENT '状态',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 授权码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_oauth2_code
-- ----------------------------

-- ----------------------------
-- Table structure for system_oauth2_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `system_oauth2_refresh_token`;
CREATE TABLE `system_oauth2_refresh_token`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `refresh_token` varchar(32) NOT NULL COMMENT '刷新令牌',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) NULL DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2038 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 刷新令牌' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_oauth2_refresh_token
-- ----------------------------

-- ----------------------------
-- Table structure for system_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `system_operate_log`;
CREATE TABLE `system_operate_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `type` varchar(50) NOT NULL COMMENT '操作模块类型',
  `sub_type` varchar(50) NOT NULL COMMENT '操作名',
  `biz_id` bigint NOT NULL COMMENT '操作数据模块编号',
  `action` varchar(2000) NOT NULL DEFAULT '' COMMENT '操作内容',
  `success` bit(1) NOT NULL DEFAULT b'1' COMMENT '操作结果',
  `extra` varchar(2000) NOT NULL DEFAULT '' COMMENT '拓展字段',
  `request_method` varchar(16) NULL DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) NULL DEFAULT '' COMMENT '请求地址',
  `user_ip` varchar(50) NULL DEFAULT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) NULL DEFAULT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9090 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志记录 V2 版本' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_operate_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_post
-- ----------------------------
DROP TABLE IF EXISTS `system_post`;
CREATE TABLE `system_post`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `code` varchar(64) NOT NULL COMMENT '岗位编码',
  `name` varchar(50) NOT NULL COMMENT '岗位名称',
  `sort` int NOT NULL COMMENT '显示顺序',
  `status` tinyint NOT NULL COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_post
-- ----------------------------

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) NOT NULL COMMENT '角色名称',
  `code` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` tinyint NOT NULL DEFAULT 1 COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `data_scope_dept_ids` varchar(500) NOT NULL DEFAULT '' COMMENT '数据范围(指定部门数组)',
  `status` tinyint NOT NULL COMMENT '角色状态（0正常 1停用）',
  `type` tinyint NOT NULL COMMENT '角色类型',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 159 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_role
-- ----------------------------
INSERT INTO `ruoyi-vue-pro`.`system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '超级管理员', 'super_admin', 1, 1, '', 0, 1, '超级管理员', '1', '2021-01-05 17:03:48', '1', '2025-06-21 14:33:40', b'0', 1);
INSERT INTO `ruoyi-vue-pro`.`system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '普通角色', 'common', 2, 2, '', 0, 1, '普通角色', '1', '2021-01-05 17:03:48', '1', '2025-06-21 14:33:40', b'0', 1);

-- ----------------------------
-- Table structure for system_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_role_menu`;
CREATE TABLE `system_role_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6139 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for system_sms_channel
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_channel`;
CREATE TABLE `system_sms_channel`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `signature` varchar(12) NOT NULL COMMENT '短信签名',
  `code` varchar(63) NOT NULL COMMENT '渠道编码',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `api_key` varchar(128) NOT NULL COMMENT '短信 API 的账号',
  `api_secret` varchar(128) NULL DEFAULT NULL COMMENT '短信 API 的秘钥',
  `callback_url` varchar(255) NULL DEFAULT NULL COMMENT '短信发送回调 URL',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '短信渠道' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_sms_channel
-- ----------------------------

-- ----------------------------
-- Table structure for system_sms_code
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_code`;
CREATE TABLE `system_sms_code`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `mobile` varchar(11) NOT NULL COMMENT '手机号',
  `code` varchar(6) NOT NULL COMMENT '验证码',
  `create_ip` varchar(15) NOT NULL COMMENT '创建 IP',
  `scene` tinyint NOT NULL COMMENT '发送场景',
  `today_index` tinyint NOT NULL COMMENT '今日发送的第几条',
  `used` tinyint NOT NULL COMMENT '是否使用',
  `used_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `used_ip` varchar(255) NULL DEFAULT NULL COMMENT '使用 IP',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_mobile`(`mobile` ASC) USING BTREE COMMENT '手机号'
) ENGINE = InnoDB AUTO_INCREMENT = 666 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '手机验证码' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_sms_code
-- ----------------------------

-- ----------------------------
-- Table structure for system_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_log`;
CREATE TABLE `system_sms_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) NOT NULL COMMENT '短信渠道编码',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) NOT NULL COMMENT '模板编码',
  `template_type` tinyint NOT NULL COMMENT '短信类型',
  `template_content` varchar(255) NOT NULL COMMENT '短信内容',
  `template_params` varchar(255) NOT NULL COMMENT '短信参数',
  `api_template_id` varchar(63) NOT NULL COMMENT '短信 API 的模板编号',
  `mobile` varchar(11) NOT NULL COMMENT '手机号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint NULL DEFAULT NULL COMMENT '用户类型',
  `send_status` tinyint NOT NULL DEFAULT 0 COMMENT '发送状态',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `api_send_code` varchar(63) NULL DEFAULT NULL COMMENT '短信 API 发送结果的编码',
  `api_send_msg` varchar(255) NULL DEFAULT NULL COMMENT '短信 API 发送失败的提示',
  `api_request_id` varchar(255) NULL DEFAULT NULL COMMENT '短信 API 发送返回的唯一请求 ID',
  `api_serial_no` varchar(255) NULL DEFAULT NULL COMMENT '短信 API 发送返回的序号',
  `receive_status` tinyint NOT NULL DEFAULT 0 COMMENT '接收状态',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '接收时间',
  `api_receive_code` varchar(63) NULL DEFAULT NULL COMMENT 'API 接收结果的编码',
  `api_receive_msg` varchar(255) NULL DEFAULT NULL COMMENT 'API 接收结果的说明',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1290 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '短信日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_sms_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `system_sms_template`;
CREATE TABLE `system_sms_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` tinyint NOT NULL COMMENT '模板类型',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `code` varchar(63) NOT NULL COMMENT '模板编码',
  `name` varchar(63) NOT NULL COMMENT '模板名称',
  `content` varchar(255) NOT NULL COMMENT '模板内容',
  `params` varchar(255) NOT NULL COMMENT '参数数组',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `api_template_id` varchar(63) NOT NULL COMMENT '短信 API 的模板编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) NOT NULL COMMENT '短信渠道编码',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '短信模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_sms_template
-- ----------------------------

-- ----------------------------
-- Table structure for system_social_client
-- ----------------------------
DROP TABLE IF EXISTS `system_social_client`;
CREATE TABLE `system_social_client`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) NOT NULL COMMENT '应用名',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) NOT NULL COMMENT '客户端编号',
  `client_secret` varchar(255) NOT NULL COMMENT '客户端密钥',
  `agent_id` varchar(255) NULL DEFAULT NULL COMMENT '代理编号',
  `status` tinyint NOT NULL COMMENT '状态',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社交客户端表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_social_client
-- ----------------------------

-- ----------------------------
-- Table structure for system_social_user
-- ----------------------------
DROP TABLE IF EXISTS `system_social_user`;
CREATE TABLE `system_social_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `type` tinyint NOT NULL COMMENT '社交平台的类型',
  `openid` varchar(32) NOT NULL COMMENT '社交 openid',
  `token` varchar(256) NULL DEFAULT NULL COMMENT '社交 token',
  `raw_token_info` varchar(1024) NOT NULL COMMENT '原始 Token 数据，一般是 JSON 格式',
  `nickname` varchar(32) NOT NULL COMMENT '用户昵称',
  `avatar` varchar(255) NULL DEFAULT NULL COMMENT '用户头像',
  `raw_user_info` varchar(1024) NOT NULL COMMENT '原始用户数据，一般是 JSON 格式',
  `code` varchar(256) NOT NULL COMMENT '最后一次的认证 code',
  `state` varchar(256) NULL DEFAULT NULL COMMENT '最后一次的认证 state',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社交用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_social_user
-- ----------------------------

-- ----------------------------
-- Table structure for system_social_user_bind
-- ----------------------------
DROP TABLE IF EXISTS `system_social_user_bind`;
CREATE TABLE `system_social_user_bind`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `social_user_id` bigint NOT NULL COMMENT '社交用户的编号',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 164 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社交绑定表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_social_user_bind
-- ----------------------------

-- ----------------------------
-- Table structure for system_tenant
-- ----------------------------
DROP TABLE IF EXISTS `system_tenant`;
CREATE TABLE `system_tenant`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '租户编号',
  `name` varchar(30) NOT NULL COMMENT '租户名',
  `contact_user_id` bigint NULL DEFAULT NULL COMMENT '联系人的用户编号',
  `contact_name` varchar(30) NOT NULL COMMENT '联系人',
  `contact_mobile` varchar(500) NULL DEFAULT NULL COMMENT '联系手机',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '租户状态（0正常 1停用）',
  `website` varchar(256) NULL DEFAULT '' COMMENT '绑定域名',
  `package_id` bigint NOT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `account_count` int NOT NULL COMMENT '账号数量',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '租户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_tenant
-- ----------------------------
INSERT INTO `system_tenant` VALUES (1, '安泉到家', 1, '小安', '16666666666', 0, 'localhost', 0, '2099-12-31 23:59:59', 9999, '1', '2025-06-20 00:00:00', '1', '2025-06-20 00:00:00', b'0');

-- ----------------------------
-- Table structure for system_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `system_tenant_package`;
CREATE TABLE `system_tenant_package`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `name` varchar(30) NOT NULL COMMENT '套餐名',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '租户状态（0正常 1停用）',
  `remark` varchar(256) NULL DEFAULT '' COMMENT '备注',
  `menu_ids` varchar(4096) NOT NULL COMMENT '关联的菜单编号',
  `creator` varchar(64) NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '租户套餐表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_tenant_package
-- ----------------------------

-- ----------------------------
-- Table structure for system_user_post
-- ----------------------------
DROP TABLE IF EXISTS `system_user_post`;
CREATE TABLE `system_user_post`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
  `post_id` bigint NOT NULL DEFAULT 0 COMMENT '岗位ID',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户岗位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_user_post
-- ----------------------------

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
INSERT INTO `ruoyi-vue-pro`.`system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 1, 1, '1', '2022-01-11 13:19:45', '1', '2025-06-21 14:17:36', b'0', 1);
INSERT INTO `ruoyi-vue-pro`.`system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 1, 2, '1', '2022-05-12 20:39:29', '1', '2025-06-21 14:17:43', b'0', 1);

-- ----------------------------
-- Table structure for system_users
-- ----------------------------
DROP TABLE IF EXISTS `system_users`;
CREATE TABLE `system_users`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(30) NOT NULL COMMENT '用户账号',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` varchar(30) NOT NULL COMMENT '用户昵称',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `post_ids` varchar(255) NULL DEFAULT NULL COMMENT '岗位编号数组',
  `email` varchar(50) NULL DEFAULT '' COMMENT '用户邮箱',
  `mobile` varchar(11) NULL DEFAULT '' COMMENT '手机号码',
  `sex` tinyint NULL DEFAULT 0 COMMENT '用户性别',
  `avatar` varchar(512) NULL DEFAULT '' COMMENT '头像地址',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '帐号状态（0正常 1停用）',
  `login_ip` varchar(50) NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `creator` varchar(64) NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 142 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_users
-- ----------------------------
INSERT INTO `ruoyi-vue-pro`.`system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 'admin', '$2a$04$KljJDa/LK7QfDm0lF5OhuePhlPfjRH3tB2Wu351Uidz.oQGJXevPi', '安泉到家', '管理员', 1, '[]', 'anquandaojia@qq.com', '16666666666', 2, 'http://192.168.56.128:9000/mall/20250622/logo_1750557007515.jpg', 0, '0:0:0:0:0:0:0:1', '2025-06-21 00:00:00', '1', '2025-06-20 00:00:00', '1', '2025-06-20 00:00:00', b'0', 1);

-- ----------------------------
-- Table structure for trade_after_sale
-- ----------------------------
DROP TABLE IF EXISTS `trade_after_sale`;
CREATE TABLE `trade_after_sale`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '售后订单编号，主键自增',
  `no` varchar(32) NOT NULL COMMENT '售后单号',
  `status` int NOT NULL COMMENT '退款状态（枚举 AfterSaleStatusEnum）',
  `way` int NOT NULL COMMENT '售后方式（枚举 AfterSaleWayEnum）',
  `type` int NOT NULL COMMENT '售后类型（枚举 AfterSaleTypeEnum）',
  `user_id` bigint NOT NULL COMMENT '用户编号（关联 member_user.id）',
  `apply_reason` varchar(255) NOT NULL COMMENT '申请原因',
  `apply_description` varchar(512) NULL DEFAULT NULL COMMENT '补充描述',
  `apply_pic_urls` varchar(2048) NULL COMMENT '补充凭证图片数组（JSON 格式）',
  `order_id` bigint NOT NULL COMMENT '交易订单编号（关联 trade_order.id）',
  `order_no` varchar(32) NOT NULL COMMENT '订单流水号（冗余 trade_order.no）',
  `order_item_id` bigint NOT NULL COMMENT '交易订单项编号（关联 trade_order_item.id）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号（冗余 product_spu.id）',
  `spu_name` varchar(255) NOT NULL COMMENT '商品名称',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `properties` varchar(4096) NOT NULL COMMENT '属性数组（JSON 格式）',
  `pic_url` varchar(1024) NOT NULL COMMENT '商品图片 URL',
  `count` int NOT NULL COMMENT '退货商品数量',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `audit_user_id` bigint NULL DEFAULT NULL COMMENT '审批人（admin_user.id）',
  `audit_reason` varchar(512) NULL DEFAULT NULL COMMENT '审批备注（仅在不通过时填写）',
  `refund_price` int NOT NULL COMMENT '退款金额，单位：分',
  `pay_refund_id` bigint NULL DEFAULT NULL COMMENT '支付退款编号（关联 pay_refund.id）',
  `refund_time` datetime NULL DEFAULT NULL COMMENT '退款时间',
  `logistics_id` bigint NULL DEFAULT NULL COMMENT '退货物流公司编号（关联 logistics.id）',
  `logistics_no` varchar(255) NULL DEFAULT NULL COMMENT '退货物流单号',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '退货时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `receive_reason` varchar(512) NULL DEFAULT NULL COMMENT '收货备注（拒绝收货时填写）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_no`(`no` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_order_item_id`(`order_item_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_refund_time`(`refund_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '售后订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_after_sale
-- ----------------------------

-- ----------------------------
-- Table structure for trade_after_sale_log
-- ----------------------------
DROP TABLE IF EXISTS `trade_after_sale_log`;
CREATE TABLE `trade_after_sale_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '售后日志编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '用户编号（关联 admin_user.id 或 member_user.id）',
  `user_type` int NOT NULL COMMENT '用户类型（枚举 UserTypeEnum）',
  `after_sale_id` bigint NOT NULL COMMENT '售后订单编号（关联 trade_after_sale.id）',
  `before_status` int NOT NULL COMMENT '操作前状态',
  `after_status` int NOT NULL COMMENT '操作后状态',
  `operate_type` int NOT NULL COMMENT '操作类型（枚举 AfterSaleOperateTypeEnum）',
  `content` text NOT NULL COMMENT '操作明细内容',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_after_sale_id`(`after_sale_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '交易售后日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_after_sale_log
-- ----------------------------

-- ----------------------------
-- Table structure for trade_brokerage_record
-- ----------------------------
DROP TABLE IF EXISTS `trade_brokerage_record`;
CREATE TABLE `trade_brokerage_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '佣金记录编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '用户编号（关联 member_user.id）',
  `biz_id` varchar(64) NOT NULL COMMENT '业务编号',
  `biz_type` int NOT NULL COMMENT '业务类型（枚举 BrokerageRecordBizTypeEnum）',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `description` varchar(512) NULL DEFAULT NULL COMMENT '说明',
  `price` int NOT NULL COMMENT '金额，单位：分',
  `total_price` int NOT NULL COMMENT '当前总佣金，单位：分',
  `status` int NOT NULL COMMENT '状态（枚举 BrokerageRecordStatusEnum）',
  `frozen_days` int NOT NULL COMMENT '冻结天数',
  `unfreeze_time` datetime NULL DEFAULT NULL COMMENT '解冻时间',
  `source_user_level` int NOT NULL COMMENT '来源用户等级',
  `source_user_id` bigint NOT NULL COMMENT '来源用户编号（被推广用户的编号）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_biz_id`(`biz_id` ASC) USING BTREE,
  INDEX `idx_biz_type`(`biz_type` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_unfreeze_time`(`unfreeze_time` ASC) USING BTREE,
  INDEX `idx_source_user_id`(`source_user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '佣金记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_brokerage_record
-- ----------------------------

-- ----------------------------
-- Table structure for trade_brokerage_user
-- ----------------------------
DROP TABLE IF EXISTS `trade_brokerage_user`;
CREATE TABLE `trade_brokerage_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分销用户编号，主键自增',
  `bind_user_id` bigint NULL DEFAULT NULL COMMENT '推广员编号（关联 member_user.id）',
  `bind_user_time` datetime NULL DEFAULT NULL COMMENT '推广员绑定时间',
  `brokerage_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否有分销资格（0：否，1：是）',
  `brokerage_time` datetime NULL DEFAULT NULL COMMENT '成为分销员时间',
  `brokerage_price` int NOT NULL DEFAULT 0 COMMENT '可用佣金，单位：分',
  `frozen_price` int NOT NULL DEFAULT 0 COMMENT '冻结佣金，单位：分',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_bind_user_id`(`bind_user_id` ASC) USING BTREE,
  INDEX `idx_brokerage_enabled`(`brokerage_enabled` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分销用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_brokerage_user
-- ----------------------------

-- ----------------------------
-- Table structure for trade_brokerage_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `trade_brokerage_withdraw`;
CREATE TABLE `trade_brokerage_withdraw`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '用户编号（关联 member_user.id）',
  `price` int NOT NULL COMMENT '提现金额，单位：分',
  `fee_price` int NOT NULL COMMENT '提现手续费，单位：分',
  `total_price` int NOT NULL COMMENT '当前总佣金，单位：分',
  `type` int NOT NULL COMMENT '提现类型（枚举 BrokerageWithdrawTypeEnum）',
  `user_name` varchar(255) NOT NULL COMMENT '提现姓名',
  `user_account` varchar(255) NOT NULL COMMENT '提现账号',
  `qr_code_url` varchar(1024) NULL DEFAULT NULL COMMENT '收款码 URL',
  `bank_name` varchar(255) NULL DEFAULT NULL COMMENT '银行名称',
  `bank_address` varchar(255) NULL DEFAULT NULL COMMENT '开户地址',
  `status` int NOT NULL COMMENT '状态（枚举 BrokerageWithdrawStatusEnum）',
  `audit_reason` varchar(512) NULL DEFAULT NULL COMMENT '审核驳回原因',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注信息',
  `pay_transfer_id` bigint NULL DEFAULT NULL COMMENT '转账单编号（关联 pay_transfer.id）',
  `transfer_channel_code` varchar(64) NULL DEFAULT NULL COMMENT '转账渠道（枚举 PayChannelEnum）',
  `transfer_time` datetime NULL DEFAULT NULL COMMENT '转账成功时间',
  `transfer_error_msg` varchar(512) NULL DEFAULT NULL COMMENT '转账错误提示',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '佣金提现表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_brokerage_withdraw
-- ----------------------------

-- ----------------------------
-- Table structure for trade_cart
-- ----------------------------
DROP TABLE IF EXISTS `trade_cart`;
CREATE TABLE `trade_cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车编号，主键自增',
  `user_id` bigint NOT NULL COMMENT '用户编号（关联 member_user.id）',
  `spu_id` bigint NOT NULL COMMENT '商品 SPU 编号（关联 product_spu.id）',
  `sku_id` bigint NOT NULL COMMENT '商品 SKU 编号',
  `count` int NOT NULL COMMENT '购买数量',
  `selected` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否选中（0：否，1：是）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_spu_id`(`spu_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_cart
-- ----------------------------

-- ----------------------------
-- Table structure for trade_config
-- ----------------------------
DROP TABLE IF EXISTS `trade_config`;
CREATE TABLE `trade_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `after_sale_refund_reasons` varchar(2048) NULL COMMENT '售后的退款理由',
  `after_sale_return_reasons` varchar(2048) NULL COMMENT '售后的退货理由',
  `delivery_express_free_enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用全场包邮',
  `delivery_express_free_price` int NULL DEFAULT NULL COMMENT '全场包邮的最小金额，单位：分',
  `delivery_pick_up_enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否开启自提',
  `brokerage_enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用分佣',
  `brokerage_enabled_condition` int NULL DEFAULT NULL COMMENT '分佣模式',
  `brokerage_bind_mode` int NULL DEFAULT NULL COMMENT '分销关系绑定模式',
  `brokerage_poster_urls` varchar(2048) NULL COMMENT '分销海报图地址数组',
  `brokerage_first_percent` int NULL DEFAULT NULL COMMENT '一级返佣比例',
  `brokerage_second_percent` int NULL DEFAULT NULL COMMENT '二级返佣比例',
  `brokerage_withdraw_min_price` int NULL DEFAULT NULL COMMENT '用户提现最低金额',
  `brokerage_withdraw_fee_percent` int NULL DEFAULT NULL COMMENT '用户提现手续费百分比',
  `brokerage_frozen_days` int NULL DEFAULT NULL COMMENT '佣金冻结时间(天)',
  `brokerage_withdraw_types` varchar(2048) NULL COMMENT '提现方式',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT NULL COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '交易中心配置 DO' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_config
-- ----------------------------

-- ----------------------------
-- Table structure for trade_delivery_express
-- ----------------------------
DROP TABLE IF EXISTS `trade_delivery_express`;
CREATE TABLE `trade_delivery_express`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '快递公司编号，主键自增',
  `code` varchar(64) NOT NULL COMMENT '快递公司编码',
  `name` varchar(255) NOT NULL COMMENT '快递公司名称',
  `logo` varchar(1024) NULL DEFAULT NULL COMMENT '快递公司 logo 地址',
  `sort` int NOT NULL COMMENT '排序字段',
  `status` int NOT NULL COMMENT '状态（枚举 CommonStatusEnum）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '快递公司表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_delivery_express
-- ----------------------------

-- ----------------------------
-- Table structure for trade_delivery_express_template
-- ----------------------------
DROP TABLE IF EXISTS `trade_delivery_express_template`;
CREATE TABLE `trade_delivery_express_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '模板编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '模板名称',
  `charge_mode` int NOT NULL COMMENT '配送计费方式（枚举 DeliveryExpressChargeModeEnum）',
  `sort` int NOT NULL COMMENT '排序字段',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '快递运费模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_delivery_express_template
-- ----------------------------

-- ----------------------------
-- Table structure for trade_delivery_express_template_charge
-- ----------------------------
DROP TABLE IF EXISTS `trade_delivery_express_template_charge`;
CREATE TABLE `trade_delivery_express_template_charge`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '计费配置编号，主键自增',
  `template_id` bigint NOT NULL COMMENT '关联模板编号（trade_delivery_express_template.id）',
  `area_ids` varchar(1024) NOT NULL COMMENT '配送区域编号列表（JSON 格式）',
  `charge_mode` int NOT NULL COMMENT '配送计费方式（枚举 DeliveryExpressChargeModeEnum）',
  `start_count` decimal(10, 2) NOT NULL COMMENT '首件数量（件数、重量或体积）',
  `start_price` int NOT NULL COMMENT '起步价，单位：分',
  `extra_count` decimal(10, 2) NOT NULL COMMENT '续件数量（件数、重量或体积）',
  `extra_price` int NOT NULL COMMENT '额外价，单位：分',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_template_id`(`template_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '快递运费模板计费配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_delivery_express_template_charge
-- ----------------------------

-- ----------------------------
-- Table structure for trade_delivery_express_template_free
-- ----------------------------
DROP TABLE IF EXISTS `trade_delivery_express_template_free`;
CREATE TABLE `trade_delivery_express_template_free`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '包邮配置编号，主键自增',
  `template_id` bigint NOT NULL COMMENT '关联模板编号（trade_delivery_express_template.id）',
  `area_ids` varchar(1024) NOT NULL COMMENT '配送区域编号列表（JSON 格式）',
  `free_price` int NULL DEFAULT NULL COMMENT '包邮金额，单位：分',
  `free_count` int NULL DEFAULT NULL COMMENT '包邮件数',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_template_id`(`template_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '快递运费模板包邮配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_delivery_express_template_free
-- ----------------------------

-- ----------------------------
-- Table structure for trade_delivery_pick_up_store
-- ----------------------------
DROP TABLE IF EXISTS `trade_delivery_pick_up_store`;
CREATE TABLE `trade_delivery_pick_up_store`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号，主键自增',
  `name` varchar(255) NOT NULL COMMENT '门店名称',
  `introduction` varchar(512) NULL DEFAULT NULL COMMENT '门店简介',
  `phone` varchar(32) NULL DEFAULT NULL COMMENT '门店手机',
  `area_id` int NOT NULL COMMENT '区域编号',
  `detail_address` varchar(512) NOT NULL COMMENT '门店详细地址',
  `logo` varchar(1024) NULL DEFAULT NULL COMMENT '门店 logo 地址',
  `opening_time` time NOT NULL COMMENT '营业开始时间（格式 HH:mm:ss）',
  `closing_time` time NOT NULL COMMENT '营业结束时间（格式 HH:mm:ss）',
  `latitude` decimal(10, 6) NOT NULL COMMENT '纬度',
  `longitude` decimal(10, 6) NOT NULL COMMENT '经度',
  `verify_user_ids` varchar(1024) NULL COMMENT '核销员工用户编号数组（JSON 格式）',
  `status` int NOT NULL COMMENT '门店状态（枚举 CommonStatusEnum）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '自提门店表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_delivery_pick_up_store
-- ----------------------------

-- ----------------------------
-- Table structure for trade_order
-- ----------------------------
DROP TABLE IF EXISTS `trade_order`;
CREATE TABLE `trade_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单流水号',
  `type` int NULL DEFAULT NULL COMMENT '订单类型',
  `terminal` int NULL DEFAULT NULL COMMENT '订单来源',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户编号',
  `user_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户IP',
  `user_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户备注',
  `status` int NULL DEFAULT NULL COMMENT '订单状态',
  `product_count` int NULL DEFAULT NULL COMMENT '购买的商品数量',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '订单完成时间',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '订单取消时间',
  `cancel_type` int NULL DEFAULT NULL COMMENT '取消类型',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家备注',
  `comment_status` tinyint(1) NULL DEFAULT NULL COMMENT '是否评价',
  `brokerage_user_id` bigint NULL DEFAULT NULL COMMENT '推广人编号',
  `pay_order_id` bigint NULL DEFAULT NULL COMMENT '支付订单编号',
  `pay_status` tinyint(1) NULL DEFAULT NULL COMMENT '是否已支付',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '付款时间',
  `pay_channel_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付渠道',
  `total_price` int NULL DEFAULT NULL COMMENT '商品原价，单位：分',
  `discount_price` int NULL DEFAULT NULL COMMENT '优惠金额，单位：分',
  `delivery_price` int NULL DEFAULT NULL COMMENT '运费金额，单位：分',
  `adjust_price` int NULL DEFAULT NULL COMMENT '订单调价，单位：分',
  `pay_price` int NULL DEFAULT NULL COMMENT '应付金额（总），单位：分',
  `delivery_type` int NULL DEFAULT NULL COMMENT '配送方式',
  `logistics_id` bigint NULL DEFAULT NULL COMMENT '发货物流公司编号',
  `logistics_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货物流单号',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `receiver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人名称',
  `receiver_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人手机',
  `receiver_area_id` int NULL DEFAULT NULL COMMENT '收件人地区编号',
  `receiver_detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人详细地址',
  `pick_up_store_id` bigint NULL DEFAULT NULL COMMENT '自提门店编号',
  `pick_up_verify_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自提核销码',
  `refund_status` int NULL DEFAULT NULL COMMENT '售后状态',
  `refund_price` int NULL DEFAULT NULL COMMENT '退款金额，单位：分',
  `coupon_id` bigint NULL DEFAULT NULL COMMENT '优惠劵编号',
  `coupon_price` int NULL DEFAULT NULL COMMENT '优惠劵减免金额，单位：分',
  `use_point` int NULL DEFAULT NULL COMMENT '使用的积分',
  `point_price` int NULL DEFAULT NULL COMMENT '积分抵扣的金额，单位：分',
  `give_point` int NULL DEFAULT NULL COMMENT '赠送的积分',
  `refund_point` int NULL DEFAULT NULL COMMENT '退还的使用的积分',
  `vip_price` int NULL DEFAULT NULL COMMENT 'VIP 减免金额，单位：分',
  `give_coupon_template_counts` varchar(2048) NULL COMMENT '赠送的优惠劵',
  `give_coupon_ids` varchar(1024) NULL COMMENT '赠送的优惠劵编号',
  `seckill_activity_id` bigint NULL DEFAULT NULL COMMENT '秒杀活动编号',
  `bargain_activity_id` bigint NULL DEFAULT NULL COMMENT '砍价活动编号',
  `bargain_record_id` bigint NULL DEFAULT NULL COMMENT '砍价记录编号',
  `combination_activity_id` bigint NULL DEFAULT NULL COMMENT '拼团活动编号',
  `combination_head_id` bigint NULL DEFAULT NULL COMMENT '拼团团长编号',
  `combination_record_id` bigint NULL DEFAULT NULL COMMENT '拼团记录编号',
  `point_activity_id` bigint NULL DEFAULT NULL COMMENT '积分商城活动的编号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT NULL COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '交易订单 DO' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_order
-- ----------------------------

-- ----------------------------
-- Table structure for trade_order_item
-- ----------------------------
DROP TABLE IF EXISTS `trade_order_item`;
CREATE TABLE `trade_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单项编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `order_id` bigint NOT NULL COMMENT '订单编号',
  `cart_id` bigint NULL DEFAULT NULL COMMENT '购物车项编号',
  `spu_id` bigint NOT NULL COMMENT '商品SPU编号',
  `spu_name` varchar(255) NOT NULL COMMENT '商品SPU名称',
  `sku_id` bigint NOT NULL COMMENT '商品SKU编号',
  `properties` varchar(4096) NULL COMMENT '属性数组（JSON格式）',
  `pic_url` varchar(1023) NULL DEFAULT NULL COMMENT '商品图片URL',
  `count` int NOT NULL COMMENT '购买数量',
  `comment_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否评价：0未评价，1已评价',
  `price` int NOT NULL COMMENT '商品原价（单位：分）',
  `discount_price` int NOT NULL DEFAULT 0 COMMENT '优惠金额（单位：分）',
  `delivery_price` int NOT NULL DEFAULT 0 COMMENT '运费金额（单位：分）',
  `adjust_price` int NOT NULL DEFAULT 0 COMMENT '订单调价（正数加价，负数减价）',
  `pay_price` int NOT NULL COMMENT '应付金额（单位：分）',
  `coupon_price` int NOT NULL DEFAULT 0 COMMENT '优惠券减免金额（单位：分）',
  `point_price` int NOT NULL DEFAULT 0 COMMENT '积分抵扣金额（单位：分）',
  `use_point` int NOT NULL DEFAULT 0 COMMENT '使用的积分',
  `give_point` int NOT NULL DEFAULT 0 COMMENT '赠送的积分',
  `vip_price` int NOT NULL DEFAULT 0 COMMENT 'VIP减免金额（单位：分）',
  `after_sale_id` bigint NULL DEFAULT NULL COMMENT '售后单编号',
  `after_sale_status` int NULL DEFAULT NULL COMMENT '售后状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(64) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0未删除，1已删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '交易订单项表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for trade_order_log
-- ----------------------------
DROP TABLE IF EXISTS `trade_order_log`;
CREATE TABLE `trade_order_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户编号',
  `user_type` int NULL DEFAULT NULL COMMENT '用户类型',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单号',
  `before_status` int NULL DEFAULT NULL COMMENT '操作前状态',
  `after_status` int NULL DEFAULT NULL COMMENT '操作后状态',
  `operate_type` int NULL DEFAULT NULL COMMENT '操作类型',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单日志信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NULL DEFAULT NULL COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单日志 DO' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_order_log
-- ----------------------------

-- ----------------------------
-- Table structure for trade_statistics
-- ----------------------------
DROP TABLE IF EXISTS `trade_statistics`;
CREATE TABLE `trade_statistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号，主键自增',
  `time` datetime NOT NULL COMMENT '统计日期',
  `order_create_count` int NOT NULL COMMENT '创建订单数',
  `order_pay_count` int NOT NULL COMMENT '支付订单商品数',
  `order_pay_price` int NOT NULL COMMENT '总支付金额，单位：分',
  `after_sale_count` int NOT NULL COMMENT '退款订单数',
  `after_sale_refund_price` int NOT NULL COMMENT '总退款金额，单位：分',
  `brokerage_settlement_price` int NOT NULL COMMENT '佣金金额（已结算），单位：分',
  `wallet_pay_price` int NOT NULL COMMENT '总支付金额（余额），单位：分',
  `recharge_pay_count` int NOT NULL COMMENT '充值订单数',
  `recharge_pay_price` int NOT NULL COMMENT '充值金额，单位：分',
  `recharge_refund_count` int NOT NULL COMMENT '充值退款订单数',
  `recharge_refund_price` int NOT NULL COMMENT '充值退款金额，单位：分',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `creator` varchar(255) NULL DEFAULT NULL,
  `updater` varchar(255) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_time`(`time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '交易统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for courier_user
-- ----------------------------
DROP TABLE IF EXISTS `courier_user`;
CREATE TABLE `courier_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '配送员ID（主键）',
  `username` varchar(45) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '加密后的密码',
  `nickname` varchar(45) NOT NULL COMMENT '配送员昵称',
  `avatar` varchar(255) NOT NULL COMMENT '配送员头像URL',
  `mobile` varchar(45) NOT NULL COMMENT '手机号码',
  `score` decimal(3,1) NOT NULL DEFAULT 5.0 COMMENT '评分（1-5分，保留一位小数）',
  `status` int NOT NULL DEFAULT 1 COMMENT '账号状态 (枚举 CommonStatusEnum)',
  `work_status` int NOT NULL DEFAULT 0 COMMENT '工作状态（0-休息中，1-空闲，2-配送中）',
  `login_ip` varchar(45) NOT NULL COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `creator` varchar(255) NULL DEFAULT NULL COMMENT '创建者',
  `updater` varchar(255) NULL DEFAULT NULL COMMENT '更新者',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `uk_mobile`(`mobile` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '配送员用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of courier_user
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
