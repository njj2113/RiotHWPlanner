<subgoal>
  <form if={ !subgoalText }>
    <button type="button" name="removeSubgoal" onclick={ removeSubgoal }>x</button>
    <input type="text" ref="subgoalInput">
    <input type="date" ref="subgoalDate">
    <button type="button" name="saveSubgoal" onclick={ saveSubgoal }>Save</button>
  </form>
  <div if={ subgoalText } class={ complete: done }>
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
  </style>
  <script>
    this.subgoalText;
    this.subgoalDue;
    this.saveSubgoal = function(event){
      this.subgoalText = this.refs.subgoalInput.value;
      this.subgoalDue = this.refs.subgoalDate.value;
      this.done = false;
    }
    this.removeSubgoal = function(event){
      this.unmount();
    }
  </script>
</subgoal>
