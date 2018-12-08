#pragma once

#include <string>

class Node {
};

class Root {
public:
    virtual bool matches(void *other) = 0;
};

class IntRoot : public Root {
public:
    int value;
    IntRoot(int value) : value(value) {}
    bool matches(void *other);
};

class StrRoot : public Root {
public:
    std::string value;
    StrRoot(std::string *value) : value(*value) {}
    bool matches(void *other);
};

class NodeRoot : public Root {
public:
    Node *value;
    NodeRoot(Node *value) : value(value) {}
    bool matches(void *other);
};
