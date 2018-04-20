# 简介

一款针对于UITableview和UICollectionView数据为空的加载视图,绝对解耦,一行代码集成,分为自动和普通模式,界面由xib开发,可以随意根据需求定制空视图加载界面,灵活简便.

## 手动安装

#### 1 通过 Clone or download 下载 EmptyViewSet 文件夹内的所有内容。

#### 2 将 Empty 内的源文件添加(拖放)到你的工程。

#### 3 导入UIScrollView+Empty.h

#### 4 使用

```objc
//自动模式,会自动读取UITableview的元数据,没有内容时会自动加载对应界面

//只需要在- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath的代理方法里调用 checkTableViewSectionCount方法即可自动加载

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"auto"];
    cell.textLabel.text = self.mArray[indexPath.row];
    [self.tableview checkTableViewSectionCount];
    return cell;
}
```

```objc
//手动模式,根据具体的使用场景去加载和隐藏对应界面

//	显示视图
[self.tableview showEnptyView]
//	隐藏视图
[self.tableview hidenEmptyView] 

```

ColltionView的使用方式和Tableview一致

```objc
//自动模式,会自动读取ColltionView的元数据,没有内容时会自动加载对应界面

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    [self.collectionView checkTableViewSectionCount];

    return  cell;
}

```

```objc
//手动模式,根据具体的使用场景去加载和隐藏对应界面

//	显示视图
[self.collectionView showEnptyView]
//	隐藏视图
[self.collectionView hidenEmptyView] 

```

## 说明
本库的封装的自动模式是基于dataSource的array数组为空时才回展示，更确切的说是Cell的个数为零。加载数据为空时需要触发reloadData方法来呈现空白页占位图。如果有其他需求,可以用普通模式手动设置.写这个库的时候参考了一些其他比较受欢迎的开源代码,他们更多的是为我们提供了一类标准样式而非自己定制,本库的UI用xib来绘制,这样能更大程度上的满足自己定制的需求.

![](https://github.com/hanchenhao/EmptyViewSet/blob/master/empty.gif)

## 许可
EmptyViewSet 使用 MIT 许可证，详情见 LICENSE 文件。


## 联系方式
邮箱:hanchenhao@vip.qq.com




