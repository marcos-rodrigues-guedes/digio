import Foundation

protocol RequestProtocol {
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var requestTimeOut: Float { get }
}

extension RequestProtocol{
   
    var host: String {
        return "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox"
    }
    
    var header: [String: String]? {
        return nil
    }
    
    var body: [String: String]? {
        return nil
    }
    
    var requestTimeOut: Float {
        return 8.0
    }
}
