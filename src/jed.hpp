#pragma once

#include <json.hpp>
#include <list>
#include <string>

using json = nlohmann::json;

class Node {
public:
    //virtual bool matches(json *other) = 0;
};

class IdNode : public Node {
public:
    std::string id;
    IdNode(std::string id) : id(id) {}
};

class IdListNode : public Node {
public:
    std::list<std::string> idList;
    IdListNode(std::list<std::string> idList) : idList(idList) {}
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
