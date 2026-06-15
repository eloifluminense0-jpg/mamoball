#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <dispatch/dispatch.h>
#include <dlfcn.h>
#include <mach/mach_time.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct Il2CppDomain Il2CppDomain;
typedef struct Il2CppAssembly Il2CppAssembly;
typedef struct Il2CppImage Il2CppImage;
typedef struct Il2CppClass Il2CppClass;
typedef struct FieldInfo FieldInfo;
typedef struct MethodInfo {
    void *methodPointer;
} MethodInfo;

typedef Il2CppDomain *(*il2cpp_domain_get_t)(void);
typedef const Il2CppAssembly **(*il2cpp_domain_get_assemblies_t)(const Il2CppDomain *domain, size_t *size);
typedef const Il2CppImage *(*il2cpp_assembly_get_image_t)(const Il2CppAssembly *assembly);
typedef Il2CppClass *(*il2cpp_class_from_name_t)(const Il2CppImage *image, const char *namespaze, const char *name);
typedef FieldInfo *(*il2cpp_class_get_field_from_name_t)(Il2CppClass *klass, const char *name);
typedef const MethodInfo *(*il2cpp_class_get_method_from_name_t)(Il2CppClass *klass, const char *name, int argsCount);
typedef void (*il2cpp_field_static_get_value_t)(FieldInfo *field, void *value);
typedef size_t (*il2cpp_field_get_offset_t)(FieldInfo *field);
typedef void (*InputButtonVoidMethod_t)(void *self, const MethodInfo *method);
typedef void *(*ObjectReturnMethod_t)(void *self, const MethodInfo *method);
typedef int (*ObscuredFloatEncryptMethod_t)(float value, int key, const MethodInfo *method);
typedef void (*ObscuredFloatSetEncryptedMethod_t)(void *self, int encrypted, int key, const MethodInfo *method);

typedef struct {
    float x;
    float y;
} FlorkVector2;

typedef struct {
    float x;
    float y;
    float width;
    float height;
} FlorkRect;

typedef bool (*ScreenPointToLocalPointMethod_t)(void *rect, FlorkVector2 screenPoint, void *camera, FlorkVector2 *localPoint, const MethodInfo *method);
typedef FlorkRect (*GetScreenCoordinatesAsRectMethod_t)(void *rect, const MethodInfo *method);

typedef struct {
    int hash;
    int hiddenValue;
    int currentCryptoKey;
    float fakeValue;
    uint8_t hiddenValueOldByte4[4];
} ObscuredFloatValue;

enum {
    FLORK_KICK_STATE_UP = 1,
    FLORK_KICK_STATE_KICK = 2,
    FLORK_KICK_STATE_POWER_KICK = 3,
};

enum {
    FLORK_TOUCH_PHASE_BEGAN = 0,
    FLORK_TOUCH_PHASE_MOVED = 1,
    FLORK_TOUCH_PHASE_STATIONARY = 2,
    FLORK_TOUCH_PHASE_ENDED = 3,
    FLORK_TOUCH_PHASE_CANCELED = 4,
};

static const double kMaxKickDownMs = 16.0;
static const double kFrameGateFallbackMs = 34.0;
static const double kReleaseAfterRecognizedMs = 0.0;
static const double kRearmQuietMs = 18.0;
static const double kMacroKickHoldMs = 20.0;
static const double kMacroGapMs = 16.0;
static const double kMacroPowerKickHoldMs = 72.0;
static const double kKickSideSuppressMs = 180.0;
static const int kMacroMaxQueuedCount = 8;
static const CGFloat kMacroButtonSize = 96.0;
static const CGFloat kMacroButtonMargin = 24.0;
static const NSTimeInterval kMaxMacroTouchEventAgeSeconds = 0.25;
static const uint64_t kMacroHoldIntervalNs = 500ull * 1000ull;
static const uint64_t kPollIntervalNs = 500ull * 1000ull;

static il2cpp_domain_get_t p_il2cpp_domain_get;
static il2cpp_domain_get_assemblies_t p_il2cpp_domain_get_assemblies;
static il2cpp_assembly_get_image_t p_il2cpp_assembly_get_image;
static il2cpp_class_from_name_t p_il2cpp_class_from_name;
static il2cpp_class_get_field_from_name_t p_il2cpp_class_get_field_from_name;
static il2cpp_class_get_method_from_name_t p_il2cpp_class_get_method_from_name;
static il2cpp_field_static_get_value_t p_il2cpp_field_static_get_value;
static il2cpp_field_get_offset_t p_il2cpp_field_get_offset;

static FieldInfo *gGamePadLayoutInstanceField;
static FieldInfo *gMatchControllerInstanceField;
static FieldInfo *gLocalMatchControllerInstanceField;
static FieldInfo *gClientControllerInstanceField;
static const MethodInfo *gInputButtonOnPointerDownMethod;
static const MethodInfo *gInputButtonOnPointerUpMethod;
static const MethodInfo *gBaseControllerGetConfigMethod;
static const MethodInfo *gObscuredFloatEncryptMethod;
static const MethodInfo *gObscuredFloatSetEncryptedMethod;
static const MethodInfo *gScreenPointToLocalPointMethod;
static const MethodInfo *gGetScreenCoordinatesAsRectMethod;
static UIWindow *gMacroWindow;
static UIButton *gMacroButton;
static NSObject *gMacroTarget;
static UIWindow *gKickOverlayWindow;
static UIButton *gKickOverlayButton;
static NSObject *gKickOverlayTarget;
static dispatch_source_t gPollTimer;
static dispatch_source_t gKickSideTimer;
static dispatch_source_t gKickOverlayTimer;
static dispatch_source_t gTouchPolicyTimer;
static uint64_t gMacroDisabledUntilNs;
static uint64_t gKickSideSuppressUntilNs;
static CGFloat gMacroCenterRatioX = 0.0;
static CGFloat gMacroCenterRatioY = 0.0;
static bool gResolved;
static bool gMacroRunning;
static bool gMacroHasSavedCenterRatio;
static bool gCooldownPatchLogged;
static bool gTapWindowUnlockLogged;
static bool gHasSavedGamepadButtonCooldown;
static bool gKickSideObservedDown;
static bool gTrackingKickPress;
static bool gSuppressedKickPress;
static bool gKickStartInputIdValid;
static int gMacroQueuedCount;
static int gKickStartInputId;
static uint64_t gKickDownStartNs;
static uint64_t gKickRecognizedNs;
static uint64_t gKickQuietStartNs;
static uint64_t gLastCooldownPatchNs;
static ObscuredFloatValue gSavedGamepadButtonCooldown;

static size_t off_GamePadLayout_isEditMode = 0x51;
static size_t off_UnityObject_mCachedPtr = 0x10;
static size_t off_GamePadLayout_kickButtonsLayout = 0xE8;
static size_t off_GamePadLayout_mCurrentKickState = 0x138;
static size_t off_GamePadLayout_mPreviousKickStateForAccumulator = 0x170;
static size_t off_GamePadKickButtonsLayout_ibKick = 0x58;
static size_t off_GamePadKickButtonsLayout_ibPowerKick = 0x60;
static size_t off_GamePadKickButtonsLayout_mPreviousKickState = 0x70;
static size_t off_GamePadKickButtonsLayout_mLastTapTime = 0x74;
static size_t off_InputButton_rtThis = 0x30;
static size_t off_InputButton_mIsPointerDown = 0x40;
static size_t off_InputButton_mTouch = 0x44;
static size_t off_ClientController_mInputIdIndexer = 0xA0;
static size_t off_Config_gamepadButtonCooldown = 0x680;

static uint64_t NowNs(void) {
    static mach_timebase_info_data_t info;
    if (info.denom == 0) {
        mach_timebase_info(&info);
    }
    uint64_t ticks = mach_absolute_time();
    return ticks * info.numer / info.denom;
}

static uint64_t MsToNs(double ms) {
    return (uint64_t)(ms * 1000000.0);
}

static void FlorkLog(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSLog(@"[FlorkDB] %@", message);
}

static void *ResolveSymbol(const char *name) {
    void *symbol = dlsym(RTLD_DEFAULT, name);
    if (symbol) {
        return symbol;
    }

    void *unityFramework = dlopen("UnityFramework.framework/UnityFramework", RTLD_LAZY | RTLD_NOLOAD);
    if (!unityFramework) {
        unityFramework = dlopen("@rpath/UnityFramework.framework/UnityFramework", RTLD_LAZY | RTLD_NOLOAD);
    }
    if (unityFramework) {
        symbol = dlsym(unityFramework, name);
    }
    return symbol;
}

static bool ResolveIl2CppSymbols(void) {
    p_il2cpp_domain_get = (il2cpp_domain_get_t)ResolveSymbol("il2cpp_domain_get");
    p_il2cpp_domain_get_assemblies = (il2cpp_domain_get_assemblies_t)ResolveSymbol("il2cpp_domain_get_assemblies");
    p_il2cpp_assembly_get_image = (il2cpp_assembly_get_image_t)ResolveSymbol("il2cpp_assembly_get_image");
    p_il2cpp_class_from_name = (il2cpp_class_from_name_t)ResolveSymbol("il2cpp_class_from_name");
    p_il2cpp_class_get_field_from_name = (il2cpp_class_get_field_from_name_t)ResolveSymbol("il2cpp_class_get_field_from_name");
    p_il2cpp_class_get_method_from_name = (il2cpp_class_get_method_from_name_t)ResolveSymbol("il2cpp_class_get_method_from_name");
    p_il2cpp_field_static_get_value = (il2cpp_field_static_get_value_t)ResolveSymbol("il2cpp_field_static_get_value");
    p_il2cpp_field_get_offset = (il2cpp_field_get_offset_t)ResolveSymbol("il2cpp_field_get_offset");

    return p_il2cpp_domain_get &&
           p_il2cpp_domain_get_assemblies &&
           p_il2cpp_assembly_get_image &&
           p_il2cpp_class_from_name &&
           p_il2cpp_class_get_field_from_name &&
           p_il2cpp_class_get_method_from_name &&
           p_il2cpp_field_static_get_value;
}

static Il2CppClass *FindClass(const char *name) {
    Il2CppDomain *domain = p_il2cpp_domain_get();
    if (!domain) {
        return NULL;
    }

    size_t assemblyCount = 0;
    const Il2CppAssembly **assemblies = p_il2cpp_domain_get_assemblies(domain, &assemblyCount);
    if (!assemblies) {
        return NULL;
    }

    for (size_t i = 0; i < assemblyCount; i++) {
        const Il2CppImage *image = p_il2cpp_assembly_get_image(assemblies[i]);
        if (!image) {
            continue;
        }

        Il2CppClass *klass = p_il2cpp_class_from_name(image, "", name);
        if (klass) {
            return klass;
        }
    }
    return NULL;
}

static Il2CppClass *FindClassInNamespace(const char *namespaze, const char *name) {
    Il2CppDomain *domain = p_il2cpp_domain_get();
    if (!domain) {
        return NULL;
    }

    size_t assemblyCount = 0;
    const Il2CppAssembly **assemblies = p_il2cpp_domain_get_assemblies(domain, &assemblyCount);
    if (!assemblies) {
        return NULL;
    }

    for (size_t i = 0; i < assemblyCount; i++) {
        const Il2CppImage *image = p_il2cpp_assembly_get_image(assemblies[i]);
        if (!image) {
            continue;
        }

        Il2CppClass *klass = p_il2cpp_class_from_name(image, namespaze, name);
        if (klass) {
            return klass;
        }
    }
    return NULL;
}

static void UpdateOffset(Il2CppClass *klass, const char *fieldName, size_t *offset) {
    if (!klass || !p_il2cpp_class_get_field_from_name || !p_il2cpp_field_get_offset) {
        return;
    }

    FieldInfo *field = p_il2cpp_class_get_field_from_name(klass, fieldName);
    if (!field) {
        return;
    }

    size_t runtimeOffset = p_il2cpp_field_get_offset(field);
    if (runtimeOffset > 0 && runtimeOffset < 0x4000) {
        *offset = runtimeOffset;
    }
}

static bool ResolveGameLayout(void) {
    if (!ResolveIl2CppSymbols()) {
        return false;
    }

    Il2CppClass *gamePadLayoutClass = FindClass("GamePadLayout");
    Il2CppClass *kickButtonsClass = FindClass("GamePadKickButtonsLayout");
    Il2CppClass *inputButtonClass = FindClass("InputButton");
    Il2CppClass *matchControllerClass = FindClass("MatchController");
    Il2CppClass *localMatchControllerClass = FindClass("LocalMatchController");
    Il2CppClass *clientControllerClass = FindClass("ClientController");
    Il2CppClass *baseControllerClass = FindClass("BaseController");
    Il2CppClass *configClass = FindClass("Config");
    Il2CppClass *obscuredFloatClass = FindClass("ObscuredFloat");
    Il2CppClass *rectTransformUtilityClass = FindClassInNamespace("UnityEngine", "RectTransformUtility");
    Il2CppClass *viewExtensionClass = FindClass("ViewExtension");
    if (!gamePadLayoutClass || !kickButtonsClass || !inputButtonClass) {
        return false;
    }

    gGamePadLayoutInstanceField = p_il2cpp_class_get_field_from_name(gamePadLayoutClass, "instance");
    if (!gGamePadLayoutInstanceField) {
        return false;
    }
    gInputButtonOnPointerDownMethod = p_il2cpp_class_get_method_from_name(inputButtonClass, "OnPointerDown", 0);
    gInputButtonOnPointerUpMethod = p_il2cpp_class_get_method_from_name(inputButtonClass, "OnPointerUp", 0);
    if (baseControllerClass) {
        gBaseControllerGetConfigMethod = p_il2cpp_class_get_method_from_name(baseControllerClass, "GetConfig", 0);
    }
    if (obscuredFloatClass) {
        gObscuredFloatEncryptMethod = p_il2cpp_class_get_method_from_name(obscuredFloatClass, "Encrypt", 2);
        gObscuredFloatSetEncryptedMethod = p_il2cpp_class_get_method_from_name(obscuredFloatClass, "SetEncrypted", 2);
    }
    if (rectTransformUtilityClass) {
        gScreenPointToLocalPointMethod = p_il2cpp_class_get_method_from_name(rectTransformUtilityClass, "ScreenPointToLocalPointInRectangle", 4);
    }
    if (viewExtensionClass) {
        gGetScreenCoordinatesAsRectMethod = p_il2cpp_class_get_method_from_name(viewExtensionClass, "GetScreenCoordinatesAsRect", 1);
    }
    if (clientControllerClass) {
        gClientControllerInstanceField = p_il2cpp_class_get_field_from_name(clientControllerClass, "instance");
        UpdateOffset(clientControllerClass, "mInputIdIndexer", &off_ClientController_mInputIdIndexer);
    }
    if (matchControllerClass) {
        gMatchControllerInstanceField = p_il2cpp_class_get_field_from_name(matchControllerClass, "instance");
    }
    if (localMatchControllerClass) {
        gLocalMatchControllerInstanceField = p_il2cpp_class_get_field_from_name(localMatchControllerClass, "instance");
    }

    UpdateOffset(gamePadLayoutClass, "isEditMode", &off_GamePadLayout_isEditMode);
    UpdateOffset(gamePadLayoutClass, "kickButtonsLayout", &off_GamePadLayout_kickButtonsLayout);
    UpdateOffset(gamePadLayoutClass, "mCurrentKickState", &off_GamePadLayout_mCurrentKickState);
    UpdateOffset(gamePadLayoutClass, "mPreviousKickStateForAccumulator", &off_GamePadLayout_mPreviousKickStateForAccumulator);
    UpdateOffset(kickButtonsClass, "ibKick", &off_GamePadKickButtonsLayout_ibKick);
    UpdateOffset(kickButtonsClass, "ibPowerKick", &off_GamePadKickButtonsLayout_ibPowerKick);
    UpdateOffset(kickButtonsClass, "mPreviousKickState", &off_GamePadKickButtonsLayout_mPreviousKickState);
    UpdateOffset(kickButtonsClass, "mLastTapTime", &off_GamePadKickButtonsLayout_mLastTapTime);
    UpdateOffset(inputButtonClass, "rtThis", &off_InputButton_rtThis);
    UpdateOffset(inputButtonClass, "mIsPointerDown", &off_InputButton_mIsPointerDown);
    UpdateOffset(inputButtonClass, "mTouch", &off_InputButton_mTouch);
    UpdateOffset(configClass, "gamepadButtonCooldown", &off_Config_gamepadButtonCooldown);

    gResolved = true;
    FlorkLog(@"resolved offsets: layout.kickButtons=0x%zx layout.kickState=0x%zx ibKick=0x%zx ibPowerKick=0x%zx lastTap=0x%zx input.down=0x%zx client.inputId=0x%zx cfg.cooldown=0x%zx frameGate=%@ onDown=%@ onUp=%@ cfgPatch=%@",
             off_GamePadLayout_kickButtonsLayout,
             off_GamePadLayout_mCurrentKickState,
             off_GamePadKickButtonsLayout_ibKick,
             off_GamePadKickButtonsLayout_ibPowerKick,
             off_GamePadKickButtonsLayout_mLastTapTime,
             off_InputButton_mIsPointerDown,
             off_ClientController_mInputIdIndexer,
             off_Config_gamepadButtonCooldown,
             gClientControllerInstanceField ? @"yes" : @"no",
             gInputButtonOnPointerDownMethod ? @"yes" : @"no",
             gInputButtonOnPointerUpMethod ? @"yes" : @"no",
             (gBaseControllerGetConfigMethod && gObscuredFloatEncryptMethod && gObscuredFloatSetEncryptedMethod) ? @"yes" : @"no");
    return true;
}

static inline void *ReadPtr(void *base, size_t offset) {
    if (!base) {
        return NULL;
    }
    return *(void **)((uint8_t *)base + offset);
}

static inline bool IsUnityObjectAlive(void *object) {
    if (!object) {
        return false;
    }

    return ReadPtr(object, off_UnityObject_mCachedPtr) != NULL;
}

static inline bool ReadBool(void *base, size_t offset) {
    if (!base) {
        return false;
    }
    return *(bool *)((uint8_t *)base + offset);
}

static inline int ReadInt(void *base, size_t offset) {
    if (!base) {
        return 0;
    }
    return *(int *)((uint8_t *)base + offset);
}

static inline FlorkVector2 ReadVector2(void *base, size_t offset) {
    FlorkVector2 value = {0.0f, 0.0f};
    if (base) {
        value = *(FlorkVector2 *)((uint8_t *)base + offset);
    }
    return value;
}

static void *GetStaticObject(FieldInfo *field) {
    if (!field || !p_il2cpp_field_static_get_value) {
        return NULL;
    }

    void *object = NULL;
    p_il2cpp_field_static_get_value(field, &object);
    return object;
}

static inline void WriteBool(void *base, size_t offset, bool value) {
    if (base) {
        *(bool *)((uint8_t *)base + offset) = value;
    }
}

static inline void WriteFloat(void *base, size_t offset, float value) {
    if (base) {
        *(float *)((uint8_t *)base + offset) = value;
    }
}

static inline void WriteIntIfEquals(void *base, size_t offset, int expected, int value) {
    if (!base) {
        return;
    }

    int *slot = (int *)((uint8_t *)base + offset);
    if (*slot == expected) {
        *slot = value;
    }
}

static void CallInputButtonOnPointerDown(void *button) {
    if (!button || !gInputButtonOnPointerDownMethod || !gInputButtonOnPointerDownMethod->methodPointer) {
        return;
    }

    InputButtonVoidMethod_t onPointerDown = (InputButtonVoidMethod_t)gInputButtonOnPointerDownMethod->methodPointer;
    onPointerDown(button, gInputButtonOnPointerDownMethod);
}

static void CallInputButtonOnPointerUp(void *kickButton) {
    if (!kickButton || !gInputButtonOnPointerUpMethod || !gInputButtonOnPointerUpMethod->methodPointer) {
        return;
    }

    InputButtonVoidMethod_t onPointerUp = (InputButtonVoidMethod_t)gInputButtonOnPointerUpMethod->methodPointer;
    onPointerUp(kickButton, gInputButtonOnPointerUpMethod);
}

static void *GetGameConfig(void *layout) {
    if (!layout ||
        !gBaseControllerGetConfigMethod ||
        !gBaseControllerGetConfigMethod->methodPointer) {
        return NULL;
    }

    ObjectReturnMethod_t getConfig = (ObjectReturnMethod_t)gBaseControllerGetConfigMethod->methodPointer;
    return getConfig(layout, gBaseControllerGetConfigMethod);
}

static ObscuredFloatValue *GetGamepadButtonCooldown(void *layout) {
    void *config = GetGameConfig(layout);
    if (!config) {
        return NULL;
    }

    return (ObscuredFloatValue *)((uint8_t *)config + off_Config_gamepadButtonCooldown);
}

static void SaveGamepadButtonCooldown(void *layout) {
    if (gHasSavedGamepadButtonCooldown) {
        return;
    }

    ObscuredFloatValue *cooldown = GetGamepadButtonCooldown(layout);
    if (!cooldown) {
        return;
    }

    gSavedGamepadButtonCooldown = *cooldown;
    gHasSavedGamepadButtonCooldown = true;
}

static void RestoreGamepadButtonCooldown(void *layout) {
    if (!gHasSavedGamepadButtonCooldown) {
        return;
    }

    ObscuredFloatValue *cooldown = GetGamepadButtonCooldown(layout);
    if (cooldown) {
        *cooldown = gSavedGamepadButtonCooldown;
    }

    gHasSavedGamepadButtonCooldown = false;
}

static void PatchGamepadButtonCooldown(void *layout) {
    if (!gObscuredFloatEncryptMethod ||
        !gObscuredFloatSetEncryptedMethod ||
        !gObscuredFloatEncryptMethod->methodPointer ||
        !gObscuredFloatSetEncryptedMethod->methodPointer) {
        return;
    }

    ObscuredFloatValue *cooldown = GetGamepadButtonCooldown(layout);
    if (!cooldown) {
        return;
    }
    int key = cooldown->currentCryptoKey;
    if (key == 0) {
        key = 230887;
    }

    ObscuredFloatEncryptMethod_t encrypt = (ObscuredFloatEncryptMethod_t)gObscuredFloatEncryptMethod->methodPointer;
    ObscuredFloatSetEncryptedMethod_t setEncrypted = (ObscuredFloatSetEncryptedMethod_t)gObscuredFloatSetEncryptedMethod->methodPointer;
    int encryptedZero = encrypt(0.0f, key, gObscuredFloatEncryptMethod);
    setEncrypted(cooldown, encryptedZero, key, gObscuredFloatSetEncryptedMethod);
    cooldown->fakeValue = 0.0f;

    if (!gCooldownPatchLogged) {
        gCooldownPatchLogged = true;
        FlorkLog(@"patched Config.gamepadButtonCooldown to 0.0");
    }
}

static void UnlockKickTapWindow(void *kickButtons) {
    WriteFloat(kickButtons, off_GamePadKickButtonsLayout_mLastTapTime, -1000000.0f);
    if (!gTapWindowUnlockLogged) {
        gTapWindowUnlockLogged = true;
        FlorkLog(@"forcing GamePadKickButtonsLayout.mLastTapTime into the past");
    }
}

static void ForceKickUp(void *layout, void *kickButtons, void *kickButton) {
    CallInputButtonOnPointerUp(kickButton);
    WriteBool(kickButton, off_InputButton_mIsPointerDown, false);
    WriteIntIfEquals(kickButtons, off_GamePadKickButtonsLayout_mPreviousKickState, FLORK_KICK_STATE_KICK, FLORK_KICK_STATE_UP);
    WriteIntIfEquals(layout, off_GamePadLayout_mCurrentKickState, FLORK_KICK_STATE_KICK, FLORK_KICK_STATE_UP);
    WriteIntIfEquals(layout, off_GamePadLayout_mPreviousKickStateForAccumulator, FLORK_KICK_STATE_KICK, FLORK_KICK_STATE_UP);
}

static bool IsKickTouchActive(void *kickButton) {
    int phase = ReadInt(kickButton, off_InputButton_mTouch + 0x24);
    return phase == FLORK_TOUCH_PHASE_BEGAN ||
           phase == FLORK_TOUCH_PHASE_MOVED ||
           phase == FLORK_TOUCH_PHASE_STATIONARY;
}

static bool IsKickTouchOnRightHalf(void *kickButton) {
    if (!kickButton) {
        return false;
    }

    void *rectTransform = ReadPtr(kickButton, off_InputButton_rtThis);
    if (!IsUnityObjectAlive(rectTransform)) {
        return false;
    }

    FlorkVector2 touchPosition = ReadVector2(kickButton, off_InputButton_mTouch + 0x4);
    if (gGetScreenCoordinatesAsRectMethod && gGetScreenCoordinatesAsRectMethod->methodPointer) {
        GetScreenCoordinatesAsRectMethod_t getScreenRect = (GetScreenCoordinatesAsRectMethod_t)gGetScreenCoordinatesAsRectMethod->methodPointer;
        FlorkRect rect = getScreenRect(rectTransform, gGetScreenCoordinatesAsRectMethod);
        if (rect.width > 1.0f) {
            return touchPosition.x >= rect.x + (rect.width * 0.5f);
        }
    }

    if (!gScreenPointToLocalPointMethod || !gScreenPointToLocalPointMethod->methodPointer) {
        return false;
    }

    FlorkVector2 localPoint = {0.0f, 0.0f};
    ScreenPointToLocalPointMethod_t screenToLocal = (ScreenPointToLocalPointMethod_t)gScreenPointToLocalPointMethod->methodPointer;
    if (!screenToLocal(rectTransform, touchPosition, NULL, &localPoint, gScreenPointToLocalPointMethod)) {
        return false;
    }

    return localPoint.x >= 0.0f;
}

typedef struct {
    void *layout;
    void *kickButtons;
    void *kickButton;
    void *powerKickButton;
} FlorkGamePadRefs;

typedef void (^FlorkVoidBlock)(void);

enum {
    FLORK_MACRO_BUTTON_KICK = 1,
    FLORK_MACRO_BUTTON_POWER_KICK = 2,
};

static bool GetGamePadRefs(FlorkGamePadRefs *refs) {
    if (!refs) {
        return false;
    }
    refs->layout = NULL;
    refs->kickButtons = NULL;
    refs->kickButton = NULL;
    refs->powerKickButton = NULL;

    if (!gResolved && !ResolveGameLayout()) {
        return false;
    }

    p_il2cpp_field_static_get_value(gGamePadLayoutInstanceField, &refs->layout);
    if (!IsUnityObjectAlive(refs->layout) ||
        ReadBool(refs->layout, off_GamePadLayout_isEditMode)) {
        return false;
    }

    refs->kickButtons = ReadPtr(refs->layout, off_GamePadLayout_kickButtonsLayout);
    if (!IsUnityObjectAlive(refs->kickButtons)) {
        return false;
    }

    refs->kickButton = ReadPtr(refs->kickButtons, off_GamePadKickButtonsLayout_ibKick);
    refs->powerKickButton = ReadPtr(refs->kickButtons, off_GamePadKickButtonsLayout_ibPowerKick);
    return IsUnityObjectAlive(refs->kickButton) && IsUnityObjectAlive(refs->powerKickButton);
}

static void ReleaseInputButton(void *button) {
    CallInputButtonOnPointerUp(button);
    WriteBool(button, off_InputButton_mIsPointerDown, false);
}

static void SetMacroButtonBusy(bool busy) {
    if (!gMacroButton) {
        return;
    }

    gMacroButton.alpha = 0.72;
    [gMacroButton setTitle:@"DB" forState:UIControlStateNormal];
}

static void SetMacroButtonFlash(NSString *title) {
    if (!gMacroButton) {
        return;
    }

    [gMacroButton setTitle:title forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(450.0 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        if (!gMacroRunning) {
            [gMacroButton setTitle:@"DB" forState:UIControlStateNormal];
            gMacroButton.alpha = 0.72;
        }
    });
}

static void StartMacroDb(void);

static void FinishMacroDb(void) {
    FlorkGamePadRefs refs;
    if (GetGamePadRefs(&refs)) {
        ReleaseInputButton(refs.kickButton);
        ReleaseInputButton(refs.powerKickButton);
        RestoreGamepadButtonCooldown(refs.layout);
    } else {
        gHasSavedGamepadButtonCooldown = false;
    }

    gMacroRunning = false;
    SetMacroButtonBusy(false);

    if (gMacroQueuedCount > 0) {
        gMacroQueuedCount--;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            StartMacroDb();
        });
    }
}

static void StartForcedButtonHold(int buttonKind, double holdMs, FlorkVoidBlock completion) {
    __block dispatch_source_t holdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    __block bool sentPointerDown = false;
    uint64_t endNs = NowNs() + MsToNs(holdMs);

    dispatch_source_set_timer(holdTimer,
                              dispatch_time(DISPATCH_TIME_NOW, 0),
                              kMacroHoldIntervalNs,
                              100ull * 1000ull);
    dispatch_source_set_event_handler(holdTimer, ^{
        FlorkGamePadRefs refs;
        if (!GetGamePadRefs(&refs)) {
            dispatch_source_cancel(holdTimer);
            gMacroDisabledUntilNs = NowNs() + MsToNs(3000.0);
            gHasSavedGamepadButtonCooldown = false;
            gMacroQueuedCount = 0;
            gMacroRunning = false;
            SetMacroButtonFlash(@"OFF");
            if (completion) {
                completion();
            }
            return;
        }

        UnlockKickTapWindow(refs.kickButtons);
        PatchGamepadButtonCooldown(refs.layout);

        void *button = (buttonKind == FLORK_MACRO_BUTTON_POWER_KICK) ? refs.powerKickButton : refs.kickButton;
        if (!sentPointerDown) {
            CallInputButtonOnPointerDown(button);
            sentPointerDown = true;
        }
        WriteBool(button, off_InputButton_mIsPointerDown, true);

        if (NowNs() >= endNs) {
            ReleaseInputButton(button);
            dispatch_source_cancel(holdTimer);
            if (completion) {
                completion();
            }
        }
    });
    dispatch_resume(holdTimer);
}

static void StartMacroDbFromKickTouch(void) {
    if (gMacroRunning) {
        if (gMacroQueuedCount < kMacroMaxQueuedCount) {
            gMacroQueuedCount++;
        }
        return;
    }

    FlorkGamePadRefs refs;
    if (!GetGamePadRefs(&refs) ||
        !gInputButtonOnPointerDownMethod ||
        !gInputButtonOnPointerUpMethod) {
        gMacroDisabledUntilNs = NowNs() + MsToNs(3000.0);
        gMacroQueuedCount = 0;
        return;
    }

    gMacroRunning = true;
    gKickSideSuppressUntilNs = NowNs() + MsToNs(kKickSideSuppressMs);
    SaveGamepadButtonCooldown(refs.layout);
    PatchGamepadButtonCooldown(refs.layout);
    UnlockKickTapWindow(refs.kickButtons);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMacroKickHoldMs * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        FlorkGamePadRefs releaseRefs;
        if (!gMacroRunning || !GetGamePadRefs(&releaseRefs)) {
            gMacroRunning = false;
            gHasSavedGamepadButtonCooldown = false;
            gMacroQueuedCount = 0;
            return;
        }

        ReleaseInputButton(releaseRefs.kickButton);
        UnlockKickTapWindow(releaseRefs.kickButtons);

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMacroGapMs * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            if (!gMacroRunning) {
                return;
            }
            StartForcedButtonHold(FLORK_MACRO_BUTTON_POWER_KICK, kMacroPowerKickHoldMs, ^{
                if (!gMacroRunning) {
                    return;
                }
                FinishMacroDb();
            });
        });
    });
}

static void StartMacroDb(void) {
    if (gMacroRunning) {
        if (gMacroQueuedCount < kMacroMaxQueuedCount) {
            gMacroQueuedCount++;
        }
        SetMacroButtonBusy(true);
        return;
    }

    uint64_t now = NowNs();
    if (gMacroDisabledUntilNs != 0 && now < gMacroDisabledUntilNs) {
        SetMacroButtonFlash(@"OFF");
        return;
    }

    FlorkGamePadRefs refs;
    if (!GetGamePadRefs(&refs) ||
        !gInputButtonOnPointerDownMethod ||
        !gInputButtonOnPointerUpMethod) {
        FlorkLog(@"macro DB failed: gamepad refs or input methods are not ready");
        gMacroDisabledUntilNs = now + MsToNs(3000.0);
        gMacroQueuedCount = 0;
        SetMacroButtonFlash(@"OFF");
        return;
    }

    gMacroRunning = true;
    SetMacroButtonBusy(true);
    SaveGamepadButtonCooldown(refs.layout);
    PatchGamepadButtonCooldown(refs.layout);
    UnlockKickTapWindow(refs.kickButtons);

    StartForcedButtonHold(FLORK_MACRO_BUTTON_KICK, kMacroKickHoldMs, ^{
        if (!gMacroRunning) {
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kMacroGapMs * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            if (!gMacroRunning) {
                return;
            }
            StartForcedButtonHold(FLORK_MACRO_BUTTON_POWER_KICK, kMacroPowerKickHoldMs, ^{
                if (!gMacroRunning) {
                    return;
                }
                FinishMacroDb();
            });
        });
    });
}

static bool IsMacroTouchEventStale(UIEvent *event) {
    if (!event) {
        return false;
    }

    NSTimeInterval age = NSProcessInfo.processInfo.systemUptime - event.timestamp;
    if (age <= kMaxMacroTouchEventAgeSeconds) {
        return false;
    }

    gMacroQueuedCount = 0;
    FlorkLog(@"ignored stale macro touch event age=%.3fs", age);
    return true;
}

static void StartMacroDbFromLiveButtonEvent(UIEvent *event) {
    if (IsMacroTouchEventStale(event)) {
        return;
    }

    if (gMacroRunning) {
        SetMacroButtonBusy(true);
        return;
    }

    gMacroQueuedCount = 0;
    StartMacroDb();
}

static void PollGamePad(void) {
    if (!gResolved && !ResolveGameLayout()) {
        return;
    }

    void *layout = NULL;
    p_il2cpp_field_static_get_value(gGamePadLayoutInstanceField, &layout);
    if (!layout || ReadBool(layout, off_GamePadLayout_isEditMode)) {
        return;
    }

    void *kickButtons = ReadPtr(layout, off_GamePadLayout_kickButtonsLayout);
    void *kickButton = ReadPtr(kickButtons, off_GamePadKickButtonsLayout_ibKick);
    void *powerKickButton = ReadPtr(kickButtons, off_GamePadKickButtonsLayout_ibPowerKick);
    if (!kickButtons || !kickButton || !powerKickButton) {
        return;
    }

    uint64_t now = NowNs();
    UnlockKickTapWindow(kickButtons);
    if (gLastCooldownPatchNs == 0 || now - gLastCooldownPatchNs >= MsToNs(250.0)) {
        gLastCooldownPatchNs = now;
        PatchGamepadButtonCooldown(layout);
    }

    bool kickDown = ReadBool(kickButton, off_InputButton_mIsPointerDown);
    void *clientController = GetStaticObject(gClientControllerInstanceField);
    bool hasFrameGate = clientController != NULL;
    int currentInputId = hasFrameGate ? ReadInt(clientController, off_ClientController_mInputIdIndexer) : 0;

    if (!kickDown) {
        if (gKickQuietStartNs == 0) {
            gKickQuietStartNs = now;
        }
        if (now - gKickQuietStartNs >= MsToNs(kRearmQuietMs)) {
            gTrackingKickPress = false;
            gSuppressedKickPress = false;
            gKickStartInputIdValid = false;
            gKickStartInputId = 0;
            gKickDownStartNs = 0;
            gKickRecognizedNs = 0;
        }
        return;
    }

    gKickQuietStartNs = 0;

    if (gSuppressedKickPress) {
        ForceKickUp(layout, kickButtons, kickButton);
        return;
    }

    if (!gTrackingKickPress) {
        gTrackingKickPress = true;
        gKickStartInputIdValid = hasFrameGate;
        gKickStartInputId = currentInputId;
        gKickDownStartNs = now;
        gKickRecognizedNs = 0;
        return;
    }

    int currentKickState = ReadInt(layout, off_GamePadLayout_mCurrentKickState);
    if (currentKickState == FLORK_KICK_STATE_KICK && gKickRecognizedNs == 0) {
        gKickRecognizedNs = now;
    }

    bool recognizedLongEnough = !hasFrameGate &&
                                gKickRecognizedNs != 0 &&
                                now - gKickRecognizedNs >= MsToNs(kReleaseAfterRecognizedMs);
    bool inputFrameAdvanced = hasFrameGate &&
                              gKickStartInputIdValid &&
                              currentInputId != gKickStartInputId &&
                              gKickRecognizedNs != 0;
    bool fallbackElapsed = gKickDownStartNs != 0 &&
                           now - gKickDownStartNs >= MsToNs(hasFrameGate ? kFrameGateFallbackMs : kMaxKickDownMs);
    if (recognizedLongEnough || inputFrameAdvanced || fallbackElapsed) {
        ForceKickUp(layout, kickButtons, kickButton);
        gSuppressedKickPress = true;
    }
}

static void PollKickSideMacro(void) {
    FlorkGamePadRefs refs;
    if (!GetGamePadRefs(&refs)) {
        gKickSideObservedDown = false;
        gKickSideSuppressUntilNs = 0;
        return;
    }

    uint64_t now = NowNs();
    bool kickDown = ReadBool(refs.kickButton, off_InputButton_mIsPointerDown);

    if (gKickSideSuppressUntilNs != 0) {
        if (now < gKickSideSuppressUntilNs) {
            if (kickDown) {
                ReleaseInputButton(refs.kickButton);
            }
            return;
        }
        gKickSideSuppressUntilNs = 0;
    }

    if (!kickDown) {
        if (!IsKickTouchActive(refs.kickButton)) {
            gKickSideObservedDown = false;
        }
        return;
    }

    if (gKickSideObservedDown) {
        return;
    }
    gKickSideObservedDown = true;

    if (!IsKickTouchOnRightHalf(refs.kickButton)) {
        return;
    }

    if (gMacroRunning) {
        if (gMacroQueuedCount < kMacroMaxQueuedCount) {
            gMacroQueuedCount++;
        }
        gKickSideSuppressUntilNs = now + MsToNs(kKickSideSuppressMs);
        ReleaseInputButton(refs.kickButton);
        return;
    }

    StartMacroDbFromKickTouch();
}

static void __attribute__((unused)) StartKickSideMonitorTimer(void) {
    if (gKickSideTimer) {
        return;
    }

    dispatch_queue_t queue = dispatch_get_main_queue();
    gKickSideTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(gKickSideTimer,
                              dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC),
                              kPollIntervalNs,
                              250ull * 1000ull);
    dispatch_source_set_event_handler(gKickSideTimer, ^{
        @autoreleasepool {
            PollKickSideMacro();
        }
    });
    dispatch_resume(gKickSideTimer);
}

static CGRect GetMacroScreenBounds(void);

static void ApplyTouchPolicyToView(UIView *view, NSUInteger depth) {
    if (!view || depth > 80) {
        return;
    }

    view.multipleTouchEnabled = YES;
    view.exclusiveTouch = NO;

    for (UIView *subview in view.subviews) {
        ApplyTouchPolicyToView(subview, depth + 1);
    }
}

static void ApplyTouchPolicyToApplicationWindows(void) {
    UIApplication *app = UIApplication.sharedApplication;
    if (!app) {
        return;
    }

    for (UIWindow *window in app.windows) {
        window.multipleTouchEnabled = YES;
        window.exclusiveTouch = NO;
        ApplyTouchPolicyToView(window.rootViewController.view, 0);
        ApplyTouchPolicyToView(window, 0);
    }
}

static void StartTouchPolicyTimer(void) {
    if (gTouchPolicyTimer) {
        return;
    }

    gTouchPolicyTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(gTouchPolicyTimer,
                              dispatch_time(DISPATCH_TIME_NOW, 0),
                              500ull * NSEC_PER_MSEC,
                              75ull * NSEC_PER_MSEC);
    dispatch_source_set_event_handler(gTouchPolicyTimer, ^{
        @autoreleasepool {
            ApplyTouchPolicyToApplicationWindows();
        }
    });
    dispatch_resume(gTouchPolicyTimer);
}

static bool GetKickRightHalfFrame(CGRect *outFrame) {
    if (!outFrame ||
        !gGetScreenCoordinatesAsRectMethod ||
        !gGetScreenCoordinatesAsRectMethod->methodPointer) {
        return false;
    }

    FlorkGamePadRefs refs;
    if (!GetGamePadRefs(&refs)) {
        return false;
    }

    void *rectTransform = ReadPtr(refs.kickButton, off_InputButton_rtThis);
    if (!IsUnityObjectAlive(rectTransform)) {
        return false;
    }

    GetScreenCoordinatesAsRectMethod_t getScreenRect = (GetScreenCoordinatesAsRectMethod_t)gGetScreenCoordinatesAsRectMethod->methodPointer;
    FlorkRect unityRect = getScreenRect(rectTransform, gGetScreenCoordinatesAsRectMethod);
    if (unityRect.width <= 2.0f || unityRect.height <= 2.0f) {
        return false;
    }

    CGRect screenBounds = GetMacroScreenBounds();
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    CGFloat screenHeight = CGRectGetHeight(screenBounds);
    CGRect buttonFrame = CGRectMake(unityRect.x,
                                    screenHeight - unityRect.y - unityRect.height,
                                    unityRect.width,
                                    unityRect.height);
    if (!CGRectIntersectsRect(buttonFrame, screenBounds)) {
        buttonFrame = CGRectMake(unityRect.x, unityRect.y, unityRect.width, unityRect.height);
    }

    CGFloat rightX = CGRectGetMidX(buttonFrame);
    CGFloat rightWidth = CGRectGetMaxX(buttonFrame) - rightX;
    CGRect rightHalf = CGRectMake(rightX, CGRectGetMinY(buttonFrame), rightWidth, CGRectGetHeight(buttonFrame));
    rightHalf = CGRectIntersection(rightHalf, CGRectMake(0.0, 0.0, screenWidth, screenHeight));
    if (CGRectIsNull(rightHalf) || CGRectGetWidth(rightHalf) <= 2.0 || CGRectGetHeight(rightHalf) <= 2.0) {
        return false;
    }

    *outFrame = rightHalf;
    return true;
}

@interface FlorkPassthroughWindow : UIWindow
@end

@implementation FlorkPassthroughWindow
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self.rootViewController.view) {
        return nil;
    }
    return hitView;
}
@end

@interface FlorkKickOverlayTarget : NSObject
- (void)handleTouchDown:(id)sender;
@end

@implementation FlorkKickOverlayTarget
- (void)handleTouchDown:(id)sender {
    StartMacroDb();
}
@end

static void RefreshKickOverlayFrame(void) {
    if (!gKickOverlayWindow || !gKickOverlayButton) {
        return;
    }

    CGRect screenBounds = GetMacroScreenBounds();
    gKickOverlayWindow.frame = screenBounds;
    gKickOverlayWindow.rootViewController.view.frame = gKickOverlayWindow.bounds;

    CGRect rightHalfFrame;
    if (!GetKickRightHalfFrame(&rightHalfFrame)) {
        FlorkGamePadRefs refs;
        if (!GetGamePadRefs(&refs)) {
            gKickOverlayButton.hidden = YES;
            return;
        }

        rightHalfFrame = CGRectMake(CGRectGetMidX(screenBounds),
                                    0.0,
                                    CGRectGetWidth(screenBounds) * 0.5,
                                    CGRectGetHeight(screenBounds));
    }

    gKickOverlayButton.hidden = NO;
    gKickOverlayButton.frame = rightHalfFrame;
}

static void InstallKickOverlay(void) {
    if (gKickOverlayWindow) {
        return;
    }

    UIApplication *app = UIApplication.sharedApplication;
    if (!app) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500.0 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            InstallKickOverlay();
        });
        return;
    }

    gKickOverlayWindow = [[FlorkPassthroughWindow alloc] initWithFrame:GetMacroScreenBounds()];
    gKickOverlayWindow.backgroundColor = UIColor.clearColor;
    gKickOverlayWindow.windowLevel = UIWindowLevelAlert + 20.0;

    UIViewController *rootController = [[UIViewController alloc] init];
    rootController.view.backgroundColor = UIColor.clearColor;
    rootController.view.userInteractionEnabled = YES;
    gKickOverlayWindow.rootViewController = rootController;

    gKickOverlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gKickOverlayButton.backgroundColor = UIColor.clearColor;
    gKickOverlayButton.hidden = YES;

    gKickOverlayTarget = [[FlorkKickOverlayTarget alloc] init];
    [gKickOverlayButton addTarget:gKickOverlayTarget action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
    [rootController.view addSubview:gKickOverlayButton];

    UIWindow *previousKeyWindow = app.keyWindow;
    [gKickOverlayWindow makeKeyAndVisible];
    if (previousKeyWindow && previousKeyWindow != gKickOverlayWindow) {
        [previousKeyWindow makeKeyWindow];
    }

    RefreshKickOverlayFrame();

    gKickOverlayTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(gKickOverlayTimer,
                              dispatch_time(DISPATCH_TIME_NOW, 500ull * NSEC_PER_MSEC),
                              200ull * NSEC_PER_MSEC,
                              50ull * NSEC_PER_MSEC);
    dispatch_source_set_event_handler(gKickOverlayTimer, ^{
        @autoreleasepool {
            RefreshKickOverlayFrame();
        }
    });
    dispatch_resume(gKickOverlayTimer);

    FlorkLog(@"kick right-half invisible DB overlay installed");
}

static void __attribute__((unused)) StartPollTimer(void) {
    if (gPollTimer) {
        return;
    }

    dispatch_queue_t queue = dispatch_get_main_queue();
    gPollTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(gPollTimer,
                              dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC),
                              kPollIntervalNs,
                              250ull * 1000ull);
    dispatch_source_set_event_handler(gPollTimer, ^{
        @autoreleasepool {
            PollGamePad();
        }
    });
    dispatch_resume(gPollTimer);
}

static CGRect GetMacroScreenBounds(void) {
    UIApplication *app = UIApplication.sharedApplication;
    UIWindow *keyWindow = app.keyWindow;
    CGRect bounds = CGRectZero;

    if (keyWindow && keyWindow != gMacroWindow && !CGRectIsEmpty(keyWindow.bounds)) {
        bounds = keyWindow.bounds;
    } else {
        bounds = UIScreen.mainScreen.bounds;
    }

    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    UIInterfaceOrientation orientation = app.statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(orientation) && height > width) {
        CGFloat tmp = width;
        width = height;
        height = tmp;
    }

    if (width <= 0.0 || height <= 0.0) {
        width = 812.0;
        height = 375.0;
    }

    return CGRectMake(0.0, 0.0, width, height);
}

static CGPoint ClampMacroCenter(CGPoint center) {
    CGRect bounds = GetMacroScreenBounds();
    CGFloat half = kMacroButtonSize * 0.5;
    CGFloat maxX = CGRectGetWidth(bounds) - half;
    CGFloat maxY = CGRectGetHeight(bounds) - half;

    if (maxX < half) {
        center.x = CGRectGetMidX(bounds);
    } else {
        center.x = fmax(half, fmin(maxX, center.x));
    }

    if (maxY < half) {
        center.y = CGRectGetMidY(bounds);
    } else {
        center.y = fmax(half, fmin(maxY, center.y));
    }

    return center;
}

static void SaveMacroCenterRatio(CGPoint center) {
    CGRect bounds = GetMacroScreenBounds();
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    if (width <= 0.0 || height <= 0.0) {
        return;
    }

    gMacroCenterRatioX = center.x / width;
    gMacroCenterRatioY = center.y / height;
    gMacroHasSavedCenterRatio = true;
}

static CGPoint DefaultMacroCenter(void) {
    CGRect bounds = GetMacroScreenBounds();
    CGFloat half = kMacroButtonSize * 0.5;
    CGPoint center = CGPointMake(CGRectGetWidth(bounds) - half - kMacroButtonMargin,
                                 half + kMacroButtonMargin);
    return ClampMacroCenter(center);
}

static void LayoutMacroButtonForCurrentOrientation(void) {
    if (!gMacroWindow) {
        return;
    }

    CGRect bounds = CGRectMake(0.0, 0.0, kMacroButtonSize, kMacroButtonSize);
    gMacroWindow.bounds = bounds;
    gMacroWindow.rootViewController.view.frame = bounds;
    gMacroButton.frame = bounds;
    gMacroButton.layer.cornerRadius = kMacroButtonSize * 0.5;

    CGPoint center;
    if (gMacroHasSavedCenterRatio) {
        CGRect screenBounds = GetMacroScreenBounds();
        center = CGPointMake(gMacroCenterRatioX * CGRectGetWidth(screenBounds),
                             gMacroCenterRatioY * CGRectGetHeight(screenBounds));
    } else {
        center = DefaultMacroCenter();
    }

    center = ClampMacroCenter(center);
    gMacroWindow.center = center;
    SaveMacroCenterRatio(center);
}

@interface MacroSecureContainer : UITextField
@end

@implementation MacroSecureContainer

- (BOOL)canBecomeFirstResponder {
    return NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    // Garante que apenas toques no botão sejam registrados
    if (hitView && gMacroButton && [hitView isDescendantOfView:gMacroButton]) {
        return hitView;
    }
    
    return nil;
}

@end

@interface FlorkMacroButtonTarget : NSObject
- (void)handleTap:(id)sender forEvent:(UIEvent *)event;
- (void)handlePan:(UIPanGestureRecognizer *)gesture;
- (void)handleScreenChange:(NSNotification *)notification;
@end

@implementation FlorkMacroButtonTarget
- (void)handleTap:(id)sender forEvent:(UIEvent *)event {
    StartMacroDbFromLiveButtonEvent(event);
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    if (!gMacroWindow) {
        return;
    }

    CGPoint translation = [gesture translationInView:gMacroWindow];
    CGPoint center = gMacroWindow.center;
    center.x += translation.x;
    center.y += translation.y;

    center = ClampMacroCenter(center);
    gMacroWindow.center = center;
    SaveMacroCenterRatio(center);
    [gesture setTranslation:CGPointZero inView:gMacroWindow];
}

- (void)handleScreenChange:(NSNotification *)notification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 120ull * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        LayoutMacroButtonForCurrentOrientation();
    });
}
@end

static void __attribute__((unused)) InstallFloatingButton(void) {
    if (gMacroWindow) {
        return;
    }

    UIApplication *app = UIApplication.sharedApplication;
    if (!app) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500.0 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            InstallFloatingButton();
        });
        return;
    }

    CGRect frame = CGRectMake(0.0, 0.0, kMacroButtonSize, kMacroButtonSize);

    gMacroWindow = [[UIWindow alloc] initWithFrame:frame];
    gMacroWindow.backgroundColor = UIColor.clearColor;
    gMacroWindow.windowLevel = UIWindowLevelAlert + 20.0;
    gMacroWindow.userInteractionEnabled = YES;
    gMacroWindow.multipleTouchEnabled = YES;
    gMacroWindow.exclusiveTouch = NO;

    UIViewController *rootController = [[UIViewController alloc] init];
    rootController.view.backgroundColor = UIColor.clearColor;
    rootController.view.userInteractionEnabled = YES;
    rootController.view.multipleTouchEnabled = YES;
    rootController.view.exclusiveTouch = NO;
    gMacroWindow.rootViewController = rootController;

    // ========================================================
    // ngc p n aparecer na tela
    // ========================================================
    MacroSecureContainer *secureContainer = [[MacroSecureContainer alloc] initWithFrame:rootController.view.bounds];
    secureContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    secureContainer.secureTextEntry = YES;
    secureContainer.backgroundColor = UIColor.clearColor;
    secureContainer.textColor = UIColor.clearColor;
    secureContainer.text = @" "; // Força a ativação da camada de senha
    secureContainer.userInteractionEnabled = YES;
    secureContainer.multipleTouchEnabled = YES;
    secureContainer.exclusiveTouch = NO;
    [rootController.view addSubview:secureContainer];

    // Força o layout para o iOS gerar as camadas internas
    [rootController.view layoutIfNeeded];
    [secureContainer layoutIfNeeded];

    // Busca a camada 'Canvas' blindada
    UIView *secureCanvas = secureContainer.subviews.firstObject;
    for (UIView *subview in secureContainer.subviews) {
        if ([NSStringFromClass([subview class]) containsString:@"Canvas"]) {
            secureCanvas = subview;
            break;
        }
    }

    if (secureCanvas) {
        secureCanvas.frame = secureContainer.bounds;
        secureCanvas.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        secureCanvas.userInteractionEnabled = YES;
        secureCanvas.multipleTouchEnabled = YES;
        secureCanvas.exclusiveTouch = NO;
        secureCanvas.clipsToBounds = NO;
    }
    // ========================================================

    // Criação do botão original
    gMacroButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gMacroButton.frame = rootController.view.bounds;
    gMacroButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gMacroButton.userInteractionEnabled = YES;
    gMacroButton.multipleTouchEnabled = YES;
    gMacroButton.exclusiveTouch = NO;
    gMacroButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.08];
    gMacroButton.alpha = 0.72;
    gMacroButton.layer.cornerRadius = kMacroButtonSize * 0.5;
    gMacroButton.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.88].CGColor;
    gMacroButton.layer.borderWidth = 3.0;
    gMacroButton.titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
    [gMacroButton setTitle:@"DB" forState:UIControlStateNormal];
    [gMacroButton setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.95] forState:UIControlStateNormal];

    gMacroTarget = [[FlorkMacroButtonTarget alloc] init];
    [gMacroButton addTarget:gMacroTarget action:@selector(handleTap:forEvent:) forControlEvents:(UIControlEventTouchDown | UIControlEventTouchDownRepeat)];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:gMacroTarget action:@selector(handlePan:)];
    panGesture.cancelsTouchesInView = NO;
    panGesture.delaysTouchesBegan = NO;
    panGesture.delaysTouchesEnded = NO;
    [gMacroButton addGestureRecognizer:panGesture];
    
    // ========================================================
    // sla q prr e essa so copiei e colei
    // ========================================================
    if (secureCanvas) {
        [secureCanvas addSubview:gMacroButton];
    } else {
        [secureContainer addSubview:gMacroButton]; // Fallback de segurança
    }

    // Mantém as notificações e configurações originais
    [NSNotificationCenter.defaultCenter addObserver:gMacroTarget
                                           selector:@selector(handleScreenChange:)
                                               name:UIApplicationDidChangeStatusBarOrientationNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:gMacroTarget
                                           selector:@selector(handleScreenChange:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
    [UIDevice.currentDevice beginGeneratingDeviceOrientationNotifications];

    UIWindow *previousKeyWindow = app.keyWindow;
    [gMacroWindow makeKeyAndVisible];
    if (previousKeyWindow && previousKeyWindow != gMacroWindow) {
        [previousKeyWindow makeKeyWindow];
    }
    LayoutMacroButtonForCurrentOrientation();
    ApplyTouchPolicyToApplicationWindows();

    FlorkLog(@"floating DB macro button installed (Invisible on screen record)");
}

__attribute__((constructor))
static void FlorkEntry(void) {
    @autoreleasepool {
        FlorkLog(@"loaded, floating DB macro mode");
        dispatch_async(dispatch_get_main_queue(), ^{
            StartTouchPolicyTimer();
            InstallFloatingButton();
        });
    }
}
