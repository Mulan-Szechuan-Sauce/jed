#include <json.hpp>
#include "jed.hpp"

using json = nlohmann::json;

bool IntRoot::matches(json *other) {
    if (other->is_number_integer()) {
        return true;
    }
    return other->get<int64_t>() == this->value;
}

bool StrRoot::matches(json *other) {
    if (other->is_string()) {
        return true;
    }
    return other->get<std::string>() == this->value;
}

bool NodeRoot::matches(json *other) {
    if ( ! other->is_primitive()) {
        return false;
    }
    return true;
}
