import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    let fileMiddleware = FileMiddleware(
        publicDirectory: app.directory.publicDirectory
    )
    app.middleware.use(fileMiddleware)
    
    try routes(app)
}
