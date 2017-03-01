this.Persist = {
  save: function(key, value, type) {
    type = type || "session"
    arr = this.load(key,type)
    if(arr == null)
      arr = []
    if(arr.length == 0){
      temp = []
      if(type == "session"){
        temp.push(value)
        sessionStorage.setItem(key, JSON.stringify(temp))
      }else if(type == "local"){
        temp.push(value)
        localStorage.setItem(key, JSON.stringify(temp))
      }
    }else if(arr.length > 0){
      if(type == "session"){
        arr.push(value)
        sessionStorage.setItem(key, JSON.stringify(arr))
      }else if(type == "local"){
        arr.push(value)
        localStorage.setItem(key, JSON.stringify(arr))
      }
    }
  },

  load: function (key, type) {
    type = type || "session"
    if(type == "session"){
      return JSON.parse(sessionStorage.getItem(key))
    }else if(type == "local"){
      return JSON.parse(localStorage.getItem(key))
    }
  }
}