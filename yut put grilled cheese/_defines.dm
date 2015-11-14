#define TRUE 1
#define FALSE 0

#define HORIZONTAL 12
#define VERTICAL 3

#define FPS 60
#define TICK_LAG (10/(FPS))
#define TILE_WIDTH SHAPE_WIDTH
#define TILE_HEIGHT SHAPE_HEIGHT

#define INTERFACE_PLANE 5
#define PICKUP_DISTANCE 16

#define size_matrix(_width_, _height_) matrix(_width_, 0, 0, 0, _height_, 0)
#define shape_matrix(_width_, _height_) size_matrix(_width_ / SHAPE_WIDTH, _height_ / SHAPE_HEIGHT)
