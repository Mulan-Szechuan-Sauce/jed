#pragma once

#include <json.hpp>
#include <string>

using json = nlohmann::json;

class Node {
};

class Root {
public:
    virtual bool matches(json *other) = 0;
};

class IntRoot : public Root {
public:
    int64_t value;
    IntRoot(int64_t value) : value(value) {}
    bool matches(json *other);
};

class StrRoot : public Root {
public:
    std::string value;
    StrRoot(std::string *value) : value(*value) {}
    bool matches(json *other);
};

class NodeRoot : public Root {
public:
    Node *value;
    NodeRoot(Node *value) : value(value) {}
    bool matches(json *other);
};
