/**
 
    联系人中的头部view
    包括：搜索、collectionView
 
 */


#import <UIKit/UIKit.h>

#define HEIGH_FOR_SEARCH_BAR (IS_PAD ? 60 : 44)
#define TAG_IDENTIFIER (@"tag_identifier")

@interface EM_ChatOppositeTagBar : UIView

@property (nonatomic, strong, readonly) UISearchBar *searchBar;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@end