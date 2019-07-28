<assignment>
  <div style="background-color: { item.color }">
    <label for="assignment">
      <input type="checkbox" ref="assignmentItem" onchange={ toggleCompletion }>
      <span class={ complete: done }>{ item.title } for { item.course }, due { item.due }</span>
      <button type="button" name="addSubgoal" onclick={ addSubgoal } show={ !done }>+</button>
      <button type="button" name="removeAssignment" onclick={ removeAssignment }>x</button>
    </label>
    <subgoal each={ item in subgoals }></subgoal>
  </div>
  <style>
    div {
      border-radius: 3px;
      border: 1px solid gray;
      max-width: 75%;
    }

    .complete {
      text-decoration: line-through;
      color: gray;
    }
  </style>
  <script>
    this.done = false;
    this.subgoals = [];
    this.addSubgoal = function(event){
      var newSubgoal;
      this.subgoals.push(newSubgoal);
    }
    this.toggleCompletion = function(event){
      this.done = !this.done;
    }
    this.removeAssignment = function(event){
      for (var i = 0; i < this.parent.assignments.length; i++) {
        if (this.parent.assignments[i].course == this.item.course && this.parent.assignments[i].title == this.item.title) {
          this.parent.assignments.splice(i, 1);
        }
      }
      this.unmount();
    }
  </script>
</assignment>
