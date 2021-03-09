
# Platzi Test

First of all I would like to thank you for the opportunity, I had a very busy week but I managed to deliver all the requirements and I hope you find this solution adequate and consider to move forward with my application.
I also implemented a few extra-requirements for extra points : D 

# ImageCache 

I wanted to implement an ImageCache wich actually stores images data for better UX and performance, also it helps to make the scroll smoother.
I used *NSCache* to implement the *ImageCache* class because it has several advantages such as it being thread-safe and removing items from cache when memory is needed by other applications. 
I implemented *ImageCache* as *Singleton* to provide a global access point for the cache system and avoid accidentally creating more than one instance. 
The *ImageCacheProtocol* declares the basic *CRUD* functions (Create, Read, Update, Delete)

# RatingView

I created the *RatingView* class making use of two *CAShapeLayer* one for the progress (rating percentage) and another one for the backgrund and used *UIBeizerPath* to create the circle paths for each layer. As to the label I created a simple *UIView* with a *UILabel* inside and settled the text through *NSAttributedString* to get the superscript aspect. 
Also added a little animation that starts from zero to the rating value for each movie. 
I used the vote average returned from TheMovieDB to calculate the rating.

# Pagination 

I used the Swift's Prefetching API that allows to perform tasks based on current scroll direction and speed. In order to make it work and for a better UX the *TableView*'s initial number of cells is the total number of popular movies available. This allows the user to scroll past the first page, even though you still haven't received any data of the following elements. Then, when the user scrolls past the last element, you need to request a new page.

 - The *visibleIndexPathsToReload* function is used to avoid refreshing cells that are not currently visible on the screen.
 - The *calculateIndexPathsToReload* function calculates the index paths for the last page of elements received from the API. It is used to refresh only the content that's changed, instead of reloading the whole *TableView*.

#### José Guillermo Gutiérrez Segura
