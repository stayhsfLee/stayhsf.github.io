---
title: Tricks of using springboot
date: 2019-12-12 13:09:19
tags: springboot
catagories:
- springboot
---

###1. How to escape the dollar sign in spring YAML configuration

Why not try using ${sys:$} which is ugly but effective. 
I think no one will use $ as the key.

My comment in stackoverflow: https://stackoverflow.com/a/59298031/12522484

---

###2. How does springboot deserialize the configuration object in `application/yaml` ?

SpringBoot use `constructor` and `setters (setX function)` to create the object you need.

`Lombok`: when you use @Value in your class definition, you won't get the setters and only construction of all args will be generated. So you need to use `@Data` instead of `@Value`.

`Jackson`: Polymorphic type won't work.
```
Using Id mechanism to determine the subclass.
You can use the `property` field to define which field in class is used by unique search.
@JsonTypeInfo(
    use = JsonTypeInfo.Id.NAME,
    include = JsonTypeInfo.As.EXISTING_PROPERTY,
    property = "type",
    visible = true)
@JsonSubTypes({
    @JsonSubTypes.Type(value = Dog.class, name = "type value in class")}
)
```