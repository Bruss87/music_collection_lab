require('pg')

class SqlRunner

  def SqlRunner.run( sql, values = [] )  ## defaults 'value' to empty array if no 'value' argument passed

    begin                                ## try catch - begin, ensure & end - tries to capture all eventualities
      db = PG.connect({dbname: 'music_collection', host: 'localhost'})
      db.prepare('my_query', sql)
      result = db.exec_prepared('my_query', values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
