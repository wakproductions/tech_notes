## Running the webpack development server

Doing it using vue-cli tools.

```
yarn serve
```

# Shortcuts

```
v-bind:attribute="" -> :attribute=""

:[dynamicAttributeName]=""
```

```
v-on:click="doSomething -> @click="doSomething
```

### v-model is a shortcut for
```
<input v-model="searchtext" />

// child component typically signals update:value event
<input :value="searchText" @input="searchText = $event.target.value" />

// or in Vue 2.6
            <AdditionalMaterialsSelectLineType
              :id="'additional-materials-line-type-' + index"
              v-model="value.additionalMaterials[index].lineType"
              @input="value.additionalMaterials[index].lineType = $event"
              v-bind="inputProps"
              required
            />

// Vue 3 the event to watch is @update:value

```

Other custom watcher example involving props
```
const { value } = toRefs(props)
 
 const selectedOption = ref('')

 watch(value, (newValue) => {
   console.log('updated value')
   selectedOption.value = newValue
 })

 watch(selectedOption, (newValue) => {
   console.log({emit: newValue})
   emit('input', newValue)
 })

  <FieldSelect
    v-model="value"
    :disabled="disabled"
    :error-messages="validationMessages(v$)"
    :label="label"
    :loading="loading"
    :items="items"
    :readonly="readonly"
    no-data-text="No take up options found"
    v-bind="$attrs"
    v-on="$listeners"
  />

```

https://stackoverflow.com/questions/64812098/confusion-of-properties-data-and-computed-values-when-working-with-components

### Perplexity on props

In Vue, props are indeed read-only, meaning you cannot directly mutate a prop like value in your child component when you pass it in with v-model. When using v-model with a prop named value, Vue expects the child component to emit an update event (like update:value) to notify the parent of the change instead of directly modifying the prop.

If you define a prop like:

ts
const props = defineProps<{ value: CustomerSettingsFilter }>();
and then use it with:

text
<CustomerSettingsAdditionalMaterialsUpdate
v-model="value"
:selected="selected"
/>
the child component should not mutate props.value directly. Instead, it should emit an update event when the value changes to maintain reactivity properly and avoid the "props are read-only" warning or errors.

How reactivity works with v-model and props
The parent passes in value as a prop.

Vue binds v-model="value" to a value prop and listens for update:value events.

The child component should:

Use a computed property or a local reactive copy with a getter returning the value prop.

Define a setter that emits update:value when the user changes something.

This pattern makes sure the prop is never mutated directly but changes propagate upwards via the emit event, where the parent's reactive state updates, and the new prop flows down again.

Example pattern for child
```ts
const props = defineProps<{ value: CustomerSettingsFilter }>()
const emit = defineEmits(['update:value'])

const modelValue = computed({
get: () => props.value,
set: (newValue) => emit('update:value', newValue)
})
```
In the template, bind inputs or UI to modelValue. When changed, the setter emits the update event, and the parent updates the value prop, preserving reactivity.

Summary
Props are read-only; direct mutation causes reactivity issues.

v-model on a prop means the child emits update:<prop> to update.

Use a computed property with getter/setter or a local mutable copy to handle the v-model binding.

Directly using value prop for mutation will cause warnings or non-reactive behavior.

This is the standard and correct pattern in Vue to avoid reactivity issues when using a prop as v-model binding.

---

When a child component emits the update:value event while using v-model="value" on the parent, Vue automatically listens for this event on the parent component. Even if the parent component does not explicitly define an event handler, Vue treats this specially:

Vue captures the update:value event emitted by the child.

Vue automatically updates the parent's local value data or reactive reference bound to v-model.

This works because v-model is syntactic sugar that binds the prop (value) and listens to the corresponding update:value event internally.

So, in the case where the parent has:

text
<ChildComponent v-model="value" />
and the child emits:

ts
emit('update:value', newValue)
The parent's variable value is automatically updated with newValue. This causes the parent's reactive state to change, which in turn flows back down as the new prop to the child. This two-way binding creates reactive synchronization without needing an explicit event handler on the parent side.

What happens concretely?
The parent’s value is often a ref or reactive state.

The child's update:value emission triggers that bound state to update.

This update propagates reactively through Vue's reactivity system, keeping UI consistent.

The parent does not need to write a separate event listener to handle the update explicitly.

This is how Vue's v-model works under the hood for props and custom components, providing automatic two-way binding and reactivity.

### Vuex Action vs Mutation

https://stackoverflow.com/questions/39299042/vuex-action-vs-mutations

Vuex mutations are essentially events: each mutation has a name and a handler.
Actions: Actions are just functions that dispatch mutations.

* mutation is the only way to modify state
* mutation doesn't care about business logic, it just cares about "state"
* action is business logic
* action can dispatch more than 1 mutation at a time, it just implements the business logic, it doesn't care about data changing (which manage by mutation)