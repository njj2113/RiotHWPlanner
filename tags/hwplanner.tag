<hwplanner>
  <!-- Enter the course and color you want to use -->
  <p style="margin-bottom: -4px">MENU</p>
  <div id="menu">
    <form>
      <input type="text" ref="courseName" placeholder="Subject Name" required="required">
      <select ref="courseColor" required="required">
        <option selected="selected" disabled="disabled" hidden="hidden">Select a color</option>
        <option value="#f5f5f5">White</option>
        <option value="#ed7474">Red</option>
        <option value="#7498ed">Blue</option>
        <option value="#ecfc03">Yellow</option>
        <option value="#c603fc">Purple</option>
        <option value="#fc9003">Orange</option>
        <option value="#41b064">Green</option>
        <option value="#4a3110">Brown</option>
      </select>
      <button type="button" name="confirmSubject" onclick={ addSubject }>Add</button>
    </form>

    <!-- Add assignment -->
    <form if={ courses.length > 0 }>
      <hr>
      <select ref="courseSelect">
        <option each={ item in courses }>{ item.name }</option>
      </select>
      <input type="text" ref="assignmentName" placeholder="Assignment">
      <input type="date" ref="assignmentDate">
      <button type="button" name="confirmAssignment" onclick={ addAssignment }>Add</button>
      <button type="button" name="deleteSubject" onclick={ deleteSubject }>Delete selected course</button>
    </form>

    <!-- Sorting options -->
    <button type="button" name="sortByDate" onclick={ sortByDate } if={ assignments.length > 1}>Sort by due date</button>
    <button type="button" name="sortByClass" onclick={ sortByClass } if={ assignments.length > 1}>Sort by class</button>
  </div>
  <assignment each={ item in assignments }></assignment>
  <style>
    :scope {
      width: 85%;
      height: 100%;
    }
  </style>
  <script>
    this.courses = [];
    this.assignments = [];

    this.addSubject = function (event) {
      var newSubject = {
        name: this.refs.courseName.value,
        color: this.refs.courseColor.value
      }
      this.courses.push(newSubject);
      this.refs.courseName.value = "";
    }

    this.addAssignment = function (event) {
      var newAssignment = {
        course: this.refs.courseSelect.value,
        title: this.refs.assignmentName.value,
        due: this.refs.assignmentDate.value,
        color: undefined
      }
      for (var i = 0; i < this.courses.length; i++) {
        if (this.courses[i].name == newAssignment.course) {
          newAssignment.color = this.courses[i].color;
        }
      }
      this.assignments.push(newAssignment);
      this.refs.assignmentName.value = "";
    }

    this.sortByDate = function (event) {
      function compare(a, b) {
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

    this.sortByClass = function (event) {
      function compare(a, b) {
        const classA = a.course;
        const classB = b.course;
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

    this.deleteSubject = function (event) {
      var currentSubject = this.refs.courseSelect.value;
      for (var i = 0; i < this.courses.length; i++) {
        if (this.courses[i].name == currentSubject) {
          this.courses.splice(i);
        }
      }
      /* for (var j = 0; j < this.assignments.length; j++) {
        if (this.assignments[j].course == currentSubject) {
          this.assignments.splice(j);
        }
      } */
    }
  </script>
</hwplanner>
