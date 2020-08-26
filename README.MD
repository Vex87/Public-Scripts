# Scripts

## Table of Contents
- [Core (Basic Functions)](https://github.com/Vex87/Public-Scripts#core-basic-functions)
- [Core (Custom Events)](https://github.com/Vex87/Public-Scripts#core-custom-events)

## Core (Basic Functions)

| Function | Description | Parameters | Returns |
| - | - | - | - |
| Round | Rounds a number to an optional amount of decimal places and returns that number. | Number (Double), Decimal Places (Double, Optional) | Double (The number that was rounded) |
| Get | Returns an array of instances that meet the specified class | Parent (Instance), ClassName (String) | Array (The array of instances of the specified class) |
| WaitForPath | Waits for an instance and it's entire path. | Target (Instance), Path (String), MaxWait (Double, Optional) | Instance (The instance that was waited for) |
| Mag | Returns the magnitude of two instance's &/ positions | Start (Instance/Vector3), End (Instance/Vector3) | Double (The magnitude of the two instances/positions)|
| NewThread | Creates a new thread with a specified function | Function, Parameters (Optional) | Function (The function that was threaded) |
| TableRemove | Removes a value from a table if found. | Table (Array/Dictionary), Value (Variant), RemoveCount (Double, Optional) | Double (The amount of values that was found and removed) |

## Core (Custom Events)

### Core.CreateEvent() 

```lua
-- Returns the created event
local MyEvent = Core.CreateEvent()
```

----------

### Event:Connect(Callback) 

```lua
-- Connects a function to the event
MyEvent:Connect(function(Txt)
    print(Txt)
end)
```

----------

### Event:Fire(...) 

```lua
-- Fires an event with optional parameters
MyEvent:Fire("Ice cream is awesome!")
```

----------

### Event:Wait 

```lua
-- Yields the script until the event is fired
MyEvent:Wait()
```

----------

### Event:Disconnect() 

```lua  
-- Disconnects the function from the event
MyEvent:Disconnect()
```