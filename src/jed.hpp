#pragma once

#include <string>

class Node {
};

class Root {
public:
    virtual bool matches(void *other) = 0;
};

class IntRoot : Root {
public:
    int value;
    IntRoot(int value) : value(value) {}
};

class StrRoot : Root {
public:
    std::string value;
    StrRoot(std::string value) : value(value) {}
};

class NodeRoot : Root {
public:
    Node value;
    NodeRoot(Node value) : value(value) {}
};
