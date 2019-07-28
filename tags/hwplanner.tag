<hwplanner>
  <!-- Enter the subject and color you want to use -->
  <form>
    <input type="text" ref="subjectName" placeholder="Subject Name" required>
    <select ref="subjectColor" required>
      <option selected disabled hidden>Select a color</option>
      <option value="#f5f5f5">White</option>
      <option value="#ed7474">Red</option>
      <option value="#7498ed">Blue</option>
    </select>
    <button type="button" name="confirmSubject" onclick={ addSubject }>Add</button>
  </form>
  
  <form if={ subjects.length > 0 }>
    <select ref="subjectSelect">
      <option each={ item in subjects }>{ item.name }</option>
    </select>
    <input type="text" ref="assignmentName" placeholder="Assignment">
    <input type="date" ref="assignmentDate">
    <button type="button" name="confirmAssignment" onclick={ addAssignment }>Add</button>
  </form>

  <button type="button" name="sortByDate" onclick={ sortByDate } if={ assignments.length > 1}>Sort by due date</button>
  <button type="button" name="sortByClass" onclick={ sortByClass } if={ assignments.length > 1}>Sort by class</button>
  <assignment each={ item in assignments }></assignment>
  <style>
    :scope {
      width: 85%;
      height: 100%;
    }
  </style>
  <script>
    this.subjects = [];
    this.assignments = [];
    this.addSubject = function(event){
      var newSubject = {
        name: this.refs.subjectName.value,
        color: this.refs.subjectColor.value
      }
      this.subjects.push(newSubject);
    }
    this.addAssignment = function(event){
      var newAssignment = {
        subject: this.refs.subjectSelect.value,
        title: this.refs.assignmentName.value,
        due: this.refs.assignmentDate.value,
        color: undefined
      }
      for (var i = 0; i < this.subjects.length; i++) {
        if (this.subjects[i].name == newAssignment.subject) {
          newAssignment.color = this.subjects[i].color;
        }
      }
      this.assignments.push(newAssignment);
    }
    this.sortByDate = function(event){
      function compare(a, b){
        const dateA = a.due;
        const dateB = b.due;
        let comparison = 0;
        if (dateA > dateB) {
          comparison = 1;
        } else if (dateA < dateB) {
          comparison = -1;
        }
        return comparison;
      }
      this.assignments.sort(compare);
    }
    this.sortByClass = function(event){
      function compare(a, b){
        const classA = a.subject;
        const classB = b.subject;
        let comparison = 0;
        if (classA > classB) {
          comparison = 1;
        } else if (classA < classB) {
          comparison = -1;
        }
        return comparison;
      }
      this.assignments.sort(compare);
    }
  </script>
</hwplanner>
