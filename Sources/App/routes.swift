import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    // movie/action
    app.get("movie", "action") { req async -> String in
        "Movie"
    }
    
    // MARK: - Use ':'
        // movie/comic
    app.get("movie", ":genre") { req async -> String in
        let genre = req.parameters.get("genre")
                
        return "All movies of genre: \(genre ?? "none")"
    }
    
    app.get("movie", ":genre", ":year") { req async throws -> String in
        guard let genre = req.parameters.get("genre") else {
            throw Abort(.badRequest)
        }
        
        guard let year = req.parameters.get("year") else {
            throw Abort(.badRequest)
        }
                
        return "All movies of genre: \(genre) for \(year)"
    }
    
    // customerId는 Int.self를 통해 Int만 가능
    app.get("customerId", ":customerId") { req async throws -> String in
        guard let customerId = req.parameters.get("customerId", as: Int.self) else {
            throw Abort(.badRequest)
        }
        
        return "\(customerId)"
    }
    // MARK: - Movie
    
    // GET
    app.get("movies") { req async in
        [
            Movie(title: "The Color Puple", year: 2023),
            Movie(title: "True Detective (2024)", year: 2024),
        ]
    }
    
    // POST
    app.post("movies") { req async throws in
        let movie = try req.content.decode(Movie.self)
        return movie
    }
}
