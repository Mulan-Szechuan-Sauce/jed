#pragma once

#include <json.hpp>
#include <list>
#include <string>
#include <sstream>

using json = nlohmann::json;

class Node {
    Node *next;

public:
    //virtual bool matches(json *other) = 0;
    virtual std::string repr() = 0;

    void add_next(Node *next) {
        this->next = next;
    }

    Node* get_next() {
        return next;
    }

};

class IdNode : public Node {
public:
    std::string *id;
    IdNode(std::string *id) : id(id) {}

    std::string repr() {
        return *id;
    }
};

class IdListNode : public Node {
public:
    std::list<std::string *> *idList;
    IdListNode(std::list<std::string *> *idList) : idList(idList) {}

    std::string repr() {
        std::stringstream stream;
        stream << "{";
        for (std::string *val : *idList) {
            stream << *val << ", ";
        }
        stream << "}";
        return stream.str();
    }
};

class Root {
public:
    virtual bool matches(json *other) = 0;
    virtual std::string repr() = 0;
};

class IntRoot : public Root {
public:
    int64_t value;
    IntRoot(int64_t value) : value(value) {}
    bool matches(json *other);

    std::string repr() {
        return std::to_string(value);
    }
};

class StrRoot : public Root {
public:
    std::string value;
    StrRoot(std::string *value) : value(*value) {}
    bool matches(json *other);

    std::string repr() {
        return value;
    }
};

class NodeRoot : public Root {
public:
    Node *value;
    NodeRoot(Node *value) : value(value) {}
    bool matches(json *other);

    std::string repr() {
        std::stringstream stream;
        for (Node *current = value; current; current = current->get_next()) {
            stream << "." << current->repr();
        }
        return stream.str();
    }
};
