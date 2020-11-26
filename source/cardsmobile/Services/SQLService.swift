
import Foundation
import SQLite3

class SQLService {
    
    static var sqliteEncoder: SQLite.Encoder?
    static var sqliteDecoder: SQLite.Decoder?
    private static var database: SQLite.Database?
    private static var dbPath: String = "db8.sqlite"

    static func configure() {
        
        DispatchQueue.global().async {
            do {
                let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    .appendingPathComponent(SQLService.dbPath)
                let database = try SQLite.Database(path: fileURL.path)
                try database.execute(raw: RecognizeTextService.createTable)
                SQLService.sqliteEncoder = SQLite.Encoder(database)
                SQLService.sqliteDecoder = SQLite.Decoder(database)
                SQLService.database = database
            } catch {
                print(error.localizedDescription)
            }
        }

    }
}
