<subgoal>
  <form class="subgoalEntry">
    <button type="button" name="removeSubgoal" onclick={ removeSubgoal }>x</button>
    <input type="text" ref="subgoalInput">
    <input type="date" ref="subgoalDate">
    <button type="button" name="saveSubgoal" onclick={ saveSubgoal }>Save</button>
  </form>
  <div class="evident"> <!-- class={ complete: item.done } -->
    <label for="subgoal">
      <input type="checkbox" ref="subgoalItem" onchange={ parent.toggleCompletion }>
      { subgoalText }, due { subgoalDue }
      <button type="button" name="removeSubgoal" onclick={ removeSubgoal }>x</button>
    </label>
  </div>
  <style>
    form, div {
      margin-left: 3%;
      font-size: 14px;
      border: 0px !important;
    }

    .complete {
      text-decoration: line-through;
      color: gray;
    }

    .evident {
      height: 100px;
      width: 100px;
      background-color: white;
    }
  </style>
  <script>
    var db = firebase.firestore();
    var assignmentsRef = db.collection('assignments');
    var subgoalsRef = assignmentsRef.doc(this.parent.item.id).collection('subgoals');
    var currentSubgoal = this.item.id;

    this.saveSubgoal = function(event){
      this.subgoalText = this.refs.subgoalInput.value;
      this.subgoalDue = this.refs.subgoalDate.value;
      this.subgoalTack = true;
      subgoalsRef.doc(currentSubgoal).set({ text: this.subgoalText, due: this.subgoalDue, tack: this.subgoalTack }, {merge: false});
    }

    this.removeSubgoal = function(event){
      subgoalsRef.doc(currentSubgoal).delete().then(function(){
        console.log("Deleted subgoal");
      }).catch(function(error){
        console.error("Error removing subgoal: ", error);
      });
      this.unmount();
    }
  </script>
</subgoal>
