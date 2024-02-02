from flask import Flask, request, jsonify
from proper_solution import two_sum as proper_two_sum

app = Flask(__name__)

@app.route('/', methods=['POST'])
def proper_solution():
    data = request.get_json()
    nums, target = data['nums'], data['target']
    result = proper_two_sum(nums, target)
    return jsonify({'result': result})

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'ok'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
