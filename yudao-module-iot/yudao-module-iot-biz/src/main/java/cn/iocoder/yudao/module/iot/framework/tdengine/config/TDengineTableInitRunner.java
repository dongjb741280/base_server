package cn.iocoder.yudao.module.iot.framework.tdengine.config;

import cn.iocoder.yudao.module.iot.service.device.message.IotDeviceMessageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Component;

/**
 * TDengine 表初始化的 Configuration
 *
 * @author alwayssuper
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class TDengineTableInitRunner implements ApplicationRunner {

    private final IotDeviceMessageService deviceMessageService;

    @Override
    public void run(ApplicationArguments args) {
        try {
            // 初始化设备消息表
            deviceMessageService.defineDeviceMessageStable();
        } catch (BadSqlGrammarException ex) {
            // TDengine 数据源未配置或不可用时，只记录警告，不退出系统
            // 这种情况通常是因为配置文件中 tdengine 数据源被注释掉了
            log.warn("[run][TDengine数据源未配置或不可用，跳过设备消息表初始化。如需使用IoT设备消息功能，请配置TDengine数据源]", ex.getMessage());
        } catch (Exception ex) {
            // 其他异常，可能是真正的初始化失败，记录错误但不退出系统
            // 允许系统继续启动，IoT设备消息功能可能不可用
            log.error("[run][TDengine初始化设备消息表结构失败，IoT设备消息功能可能不可用]", ex);
        }
    }

}
