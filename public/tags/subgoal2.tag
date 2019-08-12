<subgoal>
  <div>
    <label for="subgoal">
      { subgoalText }, due { subgoalDue }
      <button type="button" name="removeSubgoal" onclick={ removeSubgoal }>x</button>
    </label>
  </div>

  <script>
    var db = firebase.firestore();
    var assignmentsRef = db.collection('assignments');
    var subgoalsRef = assignmentsRef.doc(this.parent.item.id).collection('subgoals');
    var currentSubgoal = this.item.id;

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
