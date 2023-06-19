import Foundation

public enum AppError: Error, Equatable {
    case connection
    case server
    case request
    case generic
    
    var description: String {
        switch self {
        case .connection:
            return "Falha na conexão com a internet, conecte-se e tente novamente"
        case .server:
            return "Falha na comunicação com o servidor, tente novamente"
        case .request:
            return "Ocorreu uma falha na sua solicitação, tente novamente"
        case .generic:
            return "Ocorreu uma falha na sua solicitação, contate o administrador"
        }
    }
}
