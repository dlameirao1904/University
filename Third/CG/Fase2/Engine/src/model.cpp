#include "Model.hpp"

Model::Model(const std::string &path, const std::string &fileName) {
    this->file = fileName;
    std::string filePath = path + fileName;
    readVertices(filePath);
}

void Model::readVertices(const std::string& filePath) {
    std::ifstream modelfile(filePath);
    if (!modelfile) {
        throw std::runtime_error("Error opening file");
    }
    std::string m;
    std::getline(modelfile, m);
    int numvt = atoi(m.data());
    while (std::getline(modelfile, m)) {
        std::istringstream in(m);
        float x, y, z;
        in >> x >> y >> z;
        vertices.push_back(Point(x, y, z));
        in.clear();
    }
    modelfile.close();
}
