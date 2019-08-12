<assignment>
  <div style="background-color: { item.color }">
    <label for="assignment">
      <input type="checkbox" ref="assignmentItem" onchange={ toggleCompletion }>
      <span class={ complete: item.done }>{ item.title } for { item.course }, due { item.due }</span>
      <button type="button" name="addSubgoal" onclick={ addSubgoal } show={ !done }>+</button>
      <button type="button" name="removeAssignment" onclick={ removeAssignment }>x</button>
    </label>

    <subgoal each={ item in subgoals }></subgoal>

    <form>
      <button type="button" name="removeSubgoal" onclick={ removeSubgoal }>x</button>
      <input type="text" ref="subgoalInput">
      <input type="date" ref="subgoalDate">
      <button type="button" name="saveSubgoal" onclick={ saveSubgoal }>Save</button>
    </form>
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

    form, div {
      margin-left: 3%;
      font-size: 14px;
      border: 0px !important;
    }
  </style>
  <script>
    var assignmentsRef = firebase.firestore().collection('assignments');
    this.done = false;
    this.subgoals = [];
    var that = this;
    var subgoalsRef = assignmentsRef.doc(this.item.id).collection('subgoals');

    subgoalsRef.onSnapshot(function(snapshot){
      var subgoals = [];
      snapshot.forEach(function(doc){
        subgoals.push(doc.data());
      })
      that.subgoals = subgoals;
      that.update();
    })

    this.addSubgoal = function(event){
      var newSubgoal = {
        text: "",
        due: "",
        id: "",
        done: false
      }
      var newKey = subgoalsRef.doc().id;
      newSubgoal.id = newKey;
      subgoalsRef.doc(newKey).set(newSubgoal);
    }
    this.toggleCompletion = function(event){
      this.item.done = !this.item.done;
      assignmentsRef.doc(this.item.id).set({ done: this.item.done }, {merge: true});
    }
    this.removeAssignment = function(event){
      assignmentsRef.doc(this.item.id).delete().then(function(){
        console.log("Deleted assignment");
      }).catch(function(error){
        console.error("Error removing assignment: ", error);
      });
      this.unmount();
    }

    this.saveSubgoal = function(event){
      this.subgoalText = this.refs.subgoalInput.value;
      this.subgoalDue = this.refs.subgoalDate.value;
      subgoalsRef.doc(this.item.id).set({ text: this.subgoalText, due: this.subgoalDue }, {merge: true});
    }
  </script>
</assignment>
