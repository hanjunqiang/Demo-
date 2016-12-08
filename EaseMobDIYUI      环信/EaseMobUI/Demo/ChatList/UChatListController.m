/**
 
 历史聊天记录中的消息VC，当选中一个会话时候就会触发下面EM_ChatListControllerDelegate中的代理方法didSelectedWithConversation进行跳转
 
 */

#import "UChatListController.h"
#import "UChatController.h"

@interface UChatListController ()<EM_ChatListControllerDelegate>

@end

@implementation UChatListController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"message"];
        self.delegate = self; //绑定父类的代理，其实当前VC就是父类，进父类看具体代码实现
    }
    return self;
}

#pragma mark - EM_ChatListControllerDelegate中的代理方法（选中）
- (void)didSelectedWithConversation:(EMConversation *)conversation{
    UChatController *chatController = [[UChatController alloc]initWithConversation:conversation];
    [self.navigationController pushViewController:chatController animated:YES];
}

@end