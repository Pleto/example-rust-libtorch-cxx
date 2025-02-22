#include "libtorch.h"

bool is_mps_available() {
    return torch::mps::is_available();
}

std::unique_ptr<torch::Tensor> create_tensor_on_mps() {
    if (!torch::mps::is_available()) {
        return std::make_unique<torch::Tensor>();
    }
    auto tensor = torch::ones({5, 5}, torch::TensorOptions().device(torch::kMPS));
    return std::make_unique<torch::Tensor>(tensor);
}

std::unique_ptr<std::string> tensor_to_string(const torch::Tensor& tensor) {
    std::ostringstream oss;
    oss << tensor;
    return std::make_unique<std::string>(oss.str());
}