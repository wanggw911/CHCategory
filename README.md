# CHCategory：通用类别

## 一、CHCategory 说明

一些自己建的方便编程的通用类别

## 二、让 CHCategory 支持 carthage

1、创建 FrameWork

2、Build Setting：搜索：`mach`，选择 `Dynamic Library` (动态库)

3、Manage Schemes：点击 Shared

4、终端执行：`carthage build --no-skip-current`

## 三、carthage 安装

Cartfile 文件中添加 `github "wanggw911/CHCategory"`

终端执行：`carthage update --platform iOS`

## 四、Git 操作

提交：

```
git init
git add .
git commit -m "initialize"
git remote add origin https://github.com/wanggw911/CHCategory.git
git push -u origin master
```

打 tag

```
git tag -a v1.0.0 -m '初始版本'
git push origin --tags
```

## 一些其他

ios-build-framework-script.sh 脚本需要拷贝到项目中



