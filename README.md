# Basic use of Core Data

### This is a simple demo for Core Data usage with Swift 3.0 


> When creating a new project, check "Use Core Data"
> 
![自动创建模型文件](http://upload-images.jianshu.io/upload_images/3873004-22674d6bf7b0bd04.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> the auto-generated model file

![创建出来的文件](http://upload-images.jianshu.io/upload_images/3873004-99d5db789d967547.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> If "Use Core Data" was not checked at project creation, manual inserting is available

![手动创建](http://upload-images.jianshu.io/upload_images/3873004-251764adcf0b0974.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> Clicking on "Add Entity" is equivalent to the initialization of a database table. The customized entity is supposed to have its name an uppercase first letter. This interface provides options to add data dependencies.

![创建一个数据表](http://upload-images.jianshu.io/upload_images/3873004-c1e7ddcc0bc1119c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


> Core Data has different data types like a database

![数据类型](http://upload-images.jianshu.io/upload_images/3873004-79805e0cf409be6d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> "Command + B" finishes compiling and physically generates the class Person. However, these files related to the entity Person does not display in the project. If the user chooses "Manual/None" in the dropdown list, Xcode will not automatically generate the class Person files that needs manual initiation.

![6.png](http://upload-images.jianshu.io/upload_images/3873004-f173f833442ef047.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> * Manual creation: click on file CoreDataBasic.xcdatamodeld, go to Editor -> next -> next
> * Note that if not using "Manual/None" but still manually created entity files, those files will conflict with the auto-generated files.
> * It is fine to use the auto-generated NSManagedObject files. However, the same 4 files do not show in the project.

![手动创建NSManagedObject](http://upload-images.jianshu.io/upload_images/3873004-2b736bc1c5123364.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> If you manually create, the files are like belows.

![](http://upload-images.jianshu.io/upload_images/3873004-46c932fe20e13aff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


> P.S. Swift/OC should be indicated

![编程语言](http://upload-images.jianshu.io/upload_images/3873004-03e56a90691514a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
