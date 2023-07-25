#ifndef ECS_H_
#define ECS_H_

#include "src/common.h"

#define ENTITY_MAX 256
#define COMPONENT_MAX 16

enum ecs_entity_types {
    ECS_ENTITY_TYPE_NULL,
    ECS_ENTITY_TYPE_PLAYER,
    ECS_ENTITY_TYPE_ENEMY,
    ECS_ENTITY_TYPE_COIN
};

enum ecs_component_types {
    ECS_COMPONENT_TYPE_NULL,
    ECS_COMPONENT_TYPE_POSITION,
    ECS_COMPONENT_TYPE_DRAWABLE,
    ECS_COMPONENT_TYPE_PHYSICS,
    ECS_COMPONENT_TYPE_TILE_COLLISION,
    ECS_COMPONENT_TYPE_ENTITY_COLLISION
};

typedef struct ecs_entity {
    byte entity_id;
    byte entity_type;
    byte component_count;
    void *components[COMPONENT_MAX];
} ecs_entity;

typedef struct ecs_component_list {
    byte component_type;
    byte component_size;
    byte component_count;
    byte component_count_max;
    void *components;
} ecs_component_list;

typedef struct ecs_component_position {
    byte entity_id;
    int x;
    int y;
    int x_previous;
    int y_previous;
} ecs_component_position;

typedef struct ecs_component_drawable {
    byte entity_id;
    int x_offset;
    int y_offset;
    bool display;
    bool sprite_flip;
    void *drawable;
} ecs_component_drawable;

typedef struct ecs_component_physics {
    byte entity_id;
    int hspeed;
    int vspeed;
    int friction;
    int gravity;
} ecs_component_physics;

void ecs_init(void);
void ecs_shutdown(void);

#endif